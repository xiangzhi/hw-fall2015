function [u,v] = LucasKanade(It, It1, rect)
%The basic lucas kanade tracking algorithm using the inverse composition
% method as shown in the pdf document 
% https://www.ri.cmu.edu/pub_files/pub3/baker_simon_2002_3/baker_simon_2002_3.pdf

%get the height and width,+1 due to being inclusive
height = rect(4) - rect(2) + 1;
width = rect(3) - rect(1) + 1;
%create the iterators for the interpolation
itX = linspace(rect(2),rect(4),height);
itY = linspace(rect(1),rect(3),width);

%first get the template from the image
template = interp2(im2double(It),itY',itX);

%get the gradient of the templates
[tGx, tGy] = gradient(template);

%get the jacobian
%jacobian = eye(2);
%ignored since the jacobian is just an identity matrix.

%calculate the steepest descent vector
steep = [reshape(tGx,size(tGx,1) * size(tGx,2),1) reshape(tGy,size(tGy,1) * size(tGy,2),1)];
%ignored jacobian since it's an identity
%calculate the hessian
hessian = steep' * steep;
%get the inverse of the hessian
invHessian = inv(hessian);
%set the initial u and v in p
p = [0;0];
%has limit to prevent infinite loop
for c=1:1:100
    
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
    %check the exit condition
    if( norm(deltaP) <= 0.0001)
        break;
    end
    %update the p with deltaP
    p = p - deltaP;
end

%update the u and v to pass out of it
u = p(1);
v = p(2);

