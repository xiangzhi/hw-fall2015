function M = LucasKanadeAffine(It, It1, givenM,wSize)
% Affine lucas kanade tracking algorithm using the inverse composition
% method as shown in the pdf document 
% https://www.ri.cmu.edu/pub_files/pub3/baker_simon_2002_3/baker_simon_2002_3.pdf


%first get the template from the image using the given M
template = warpA(im2double(It),givenM,wSize);
%imshow(template);
%calculate the size of the template
w = size(template,2);
h = size(template,1);

%get the gradient of the templates
[tGx, tGy] = gradient(template);

%calculate the steepest descent follow by the 
%hessian
hessianT = zeros(6,6);
steep = zeros([size(template) 6]);
for y = 0:1:h-1
    for x = 0:1:w-1
        test = [tGx(y+1,x+1) tGy(y+1,x+1)];
        test = test * [x 0 y 0 1 0;0 x 0 y 0 1];
        steep(y+1,x+1,:) = test;
        hessianT = hessianT + (test' * test);
    end
end
%calculating the hessian
H = zeros(6,6);
for i=1:6
	h1 = steep(:,((i-1)*w)+1:((i-1)*w)+w);
	for j=1:6
		h2 = steep(:,((j-1)*w)+1:((j-1)*w)+w);
		H(j, i) = sum(sum((h1 .* h2)));
	end
end
ih = inv(H);


%calculate the inverse Hessian
invHessian = inv(hessianT);

%break down the given M to the m we want
givenM(1,1) = givenM(1,1) -1;
givenM(2,2) = givenM(2,2) -1;
M = reshape(givenM(1:2,:),1,6);

for i = 1:1:10
    
    %build the mMatrix
    mMatrix =[M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    %first wrap the rectangle based on Mmatrix;
    img = warpA(im2double(It1),mMatrix,wSize);
    %imshow(img);

    %compute error image
    err = img - template;
    %imshow(err);
    
    
    %update the steepest descent
    top = zeros(6,1);
    for j=1:6
        tmp = steep(:,((j-1)*w)+1:((j-1)*w)+w);
        top(j) = sum(sum(tmp.* err));
    end
    %find delta p
    deltaP = invHessian * top;
    
    %check whether we reach the exit factor
    %disp(norm(deltaP))
    if( norm(deltaP) <= 0.001)
        %imshow(img);
        break;
    end
    

    %now we update it the warpMatrix
    deltaPmatrix = [deltaP(1)+1 deltaP(3) deltaP(5); ...
        deltaP(2) deltaP(4)+1 deltaP(6);0 0 1];
    %inverse the matrix
    deltaPmatrix = inv(deltaPmatrix);
    %make the current matrix
    mMatrix = [M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    %composition of both matrices
    newMatrix = mMatrix * deltaPmatrix;
    newMatrix(1,1) = newMatrix(1,1) -1;
    newMatrix(2,2) = newMatrix(2,2) -1;
    M = reshape(newMatrix(1:2,:),1,6);
end

