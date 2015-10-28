function [u,v] = LucasKanadeBasis(It, It1, rect, bases)
% lucas kanade tracking algorithm with appearance bias using the inverse composition
% method as shown in the pdf document 
% https://www.ri.cmu.edu/pub_files/pub3/baker_simon_2002_3/baker_simon_2002_3.pdf
% and
% https://www.ri.cmu.edu/pub_files/pub3/baker_simon_2003_3/baker_simon_2003_3.pdf


%calculate the height and width
%plus one to be inclusive of the whole rectangle
height = int64(rect(4) - rect(2) + 1);
width = int64(rect(3) - rect(1) + 1);

%get the template from the image
%these are for interp2
itX = linspace(rect(2),rect(4),height);
itY = linspace(rect(1),rect(3),width);
template = interp2(im2double(It),itY',itX);
%get the gradient of the template
[tGx, tGy] = gradient(template);

%get the jacobian
%jacobian = eye(2);
%ignored for now, since it's an identity matrix

%calculate the steepest descent and hessian
%first the the gradient image * jacobian
steep = [reshape(tGx,size(tGx,1) * size(tGx,2),1) reshape(tGy,size(tGy,1) * size(tGy,2),1)];
%calculate the constant that is used in the mehtod
aConstant2 = zeros(10,2);
for i = 1:1:size(bases,3)
    for j = 1:1:size(bases,1)
        for k = 1:1:size(bases,2)
            g = [tGx(j,k) tGy(j,k)];
            aConstant2(i,:) = (aConstant2(i) + bases(j,k,i)) * g;
        end
    end
end



%create matrix to save the basis part of the equation
basisPart = zeros(size(template,1) * size(template,2),2);
%loop through for the basis part
for i = 1:1:size(template,1)
    for j=1:1:size(template,2)
        tmp = zeros(1,2);
        g = [tGx(i,j) tGy(i,j)];
        for c = 1:1:size(aConstant2,1)
            tmp = tmp + (aConstant2(c,:) * bases(i,j));
        end
        basisPart(((j-1) * size(template,1)) + i,:) = tmp;
    end
end
%final calculation for steepest descent
steep = steep - basisPart;
%calculate the hessian for the matrix
hessian = steep' * steep;
%get the inverse of hessian
invHessian = inv(hessian);
%set the intial values of u and v to be 0
p = [0;0];

%infinite loop
while true
    
    %first warp the image
    interVectorX = linspace(rect(2) +p(2),rect(4) +p(2),height);
    interVectorY = linspace(rect(1) +p(1),rect(3) +p(1),width);
    img = interp2(im2double(It1),interVectorY',interVectorX);
    
    %compute error image
    err = img - template;
    %update the steepest descent
    top = steep' * reshape(err,size(err,1)*size(err,2),1);
    %find delta p
    deltaP = invHessian * top;
    
    %disp(norm(deltaP))
    %check if we reach the exit condition
    if( norm(deltaP) <= 0.0001)
        %imshow(img);
        break;
    end
    %update the warp p
    %which is just p - deltaP
    p = p - deltaP;
end

%set the u and v values to be returned
u = p(1);
v = p(2);
