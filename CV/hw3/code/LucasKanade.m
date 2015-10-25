function [u,v] = LucasKanade(It, It1, rect)
%Lucus Kanade tracking of the system

%set original values 
u = 0;
v = 0;

h = rect(4) - rect(2);
w = rect(3) - rect(1);
%jacobian = [ones(h,w),zeros(h,w);zeros(h,w),ones(h,w)];

%first get the template of the image
template = It(rect(2):rect(4),rect(1):rect(3));
%convert tempalte to double
template = im2double(template);
%get the gradient of the image
[Gx,Gy] = imgradient(It1);
%imshow(Gy);

%p --> u and v
p = [0;0]

while(true)
    %get the interpolation vectors
    tmpIt1 = im2double(It1);
    interVectorX = linspace(rect(2)+p(1),rect(4)+p(1),h+1);
    interVectorY = linspace(rect(1)+p(2),rect(3)+p(2),w+1);
    img = interp2(tmpIt1,interVectorY',interVectorX);
    %imshow(img);
    
    %first warp the image
    %img = It1(rect(2)+p(1):rect(4)+p(1),rect(1)+p(2):rect(3)+p(2));
    %get the error
    err = template - img;
    %disp(sqrt(mean(err(:).^2)));

    %find the gradient of the image

    wGx = interp2(Gx,interVectorY',interVectorX);
    %wGx = Gx(rect(2)+p(1):rect(4)+p(1),rect(1)+p(2):rect(3)+p(2));
    %wGy = Gy(rect(2)+p(1):rect(4)+p(1),rect(1)+p(2):rect(3)+p(2));
    wGy = interp2(Gy,interVectorY',interVectorX);

    %calculate the hessian
    tmp = [reshape(wGx,size(wGx,1)*size(wGx,2),1),reshape(wGy,size(wGy,1)*size(wGy,2),1)];
    hessian = tmp' * tmp;
    invH = inv(hessian);

    %calculate the steepest descent
    errS = double(reshape(err,size(err,1)*size(err,2),1));
    test = tmp' * errS;

    deltaP = invH * test;
    if(sum(abs(deltaP)) < 0.01)
        break;
    end
    p = p + deltaP;
end

disp(p);
u = p(1);
v = p(2);





%imshow(gradientT);
%calculate the jacobian
%jacobian = eye(2); %not sure if this is correct, but it's my derevation
%Hessian = (gradientT.* jacobian)' * gradientT;

%set original values 
%u = 0;
%v = 0;

%while(1)
%    img = It1(rect(1)+u:rect(3)+u,rect(2)+v:rect(4)+v);
%    err = img - template;
    %change = inv(Hessian)*
%end

%end

