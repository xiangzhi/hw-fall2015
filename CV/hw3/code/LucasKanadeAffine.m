function M = LucasKanadeAffine(It, It1)
%Lucus Kanade tracking of the system


height = size(It,2);
width = size(It,1);
%first get the template from the image
template = im2double(It);
imshow(template);

%get the gradient of the templates
[tGx, tGy] = gradient(template);

%old stupid method, but just to be sure
hessian = zeros(6,6);
steep = zeros([size(template) 6]);
for i = 1:1:size(template,1)
    for j=1:1:size(template,2)
        test = [tGx(i,j) tGy(i,j)];
        test = test * [i j 1 0 0 0;0 0 0 i j 1];
        steep(i,j,:) = test;
        hessian = hessian + (test' * test);
    end
end

invHessian = inv(hessian);
M = zeros(1,6);
while(true)
    
    %first warp the image
    %build the Mmatrix
    Mmatrix =[M(1)+1 M(2) M(3);M(4) M(5)+1 M(6);0 0 1];
    
    %imshow(It1);
    %warp the image
    img = warpA(im2double(It1),Mmatrix,size(template));
    imshow(img);
    
    %compute error image
    err = img - template;
    %disp(sqrt(mean(err(:).^2)));

    %step 7 -- can do better than this
    top = zeros(6,1);
    for i = 1:1:size(err,1)
        for j=1:1:size(err,2)
            test = reshape(steep(i,j,:),1,6);
            top = top + (test' * err(i,j));
        end
    end
   
    %find delta p
    deltaP = invHessian * top;
    %disp(deltaP);
    %if( sqrt(mean(err(:).^2)) < 0.06)
    disp(norm(deltaP))
    if( norm(deltaP) <= 0.1)
        break;
    end
    
    %now we update it
    %make a Mmatrix
    deltaPmatrix = [deltaP(1)+1 deltaP(2) deltaP(3); ...
        deltaP(4) deltaP(5)+1 deltaP(6);0 0 1];
    %inverse the matrix
    deltaPmatrix = inv(deltaPmatrix);
    %make the current matrix
    mMatrix = [M(1)+1 M(2) M(3);M(4) M(5)+1 M(6);0 0 1];
    %composition
    newMatrix = mMatrix * deltaPmatrix;
    newMatrix(1,1) = newMatrix(1,1) -1;
    newMatrix(2,2) = newMatrix(2,2) -1;
    %can't really use reshape since it messes up the way I do it
    M = [newMatrix(1,:) newMatrix(2,:)];
end

disp(M);
