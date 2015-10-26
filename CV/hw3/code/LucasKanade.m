function [u,v] = LucasKanade(It, It1, rect)
%Lucus Kanade tracking of the system

height = rect(4) - rect(2);
width = rect(3) - rect(1);
%jacobian = [ones(h,w),zeros(h,w);zeros(h,w),ones(h,w)];
itX = linspace(rect(2),rect(4),height+1);
itY = linspace(rect(1),rect(3),width+1);

%first get the template from the image
template = interp2(im2double(It),itY',itX);
imshow(template);

%get the gradient of the templates
[tGx, tGy] = gradient(template);

%get the jacobian
jacobian = eye(2);

% old stupid method, but just to be sure
% hessian = zeros(2,2);
% for i = 1:1:size(template,1)
%     for j=1:1:size(template,2)
%         test = [tGx(i,j) tGy(i,j)];
%         hessian = hessian + (test' * test);
%     end
% end

steep = [reshape(tGx,size(tGx,1) * size(tGx,2),1) reshape(tGy,size(tGy,1) * size(tGy,2),1)];
%ignored jacobian since it's an identity
hessian = steep' * steep;
invHessian = inv(hessian);
p = [0;0];
while(true)
    
    %first warp the image
 
    interVectorX = linspace(rect(2) +p(2),rect(4) +p(2),height+1);
    interVectorY = linspace(rect(1) +p(1),rect(3) +p(1),width+1);
    img = interp2(im2double(It1),interVectorY',interVectorX);
    %imshow(img);
    
    %compute error image
    err = img - template;
    %disp(sqrt(mean(err(:).^2)));

    %step 7 -- can do better than this
    top = steep' * reshape(err,size(err,1)*size(err,2),1);
%     top = zeros(2,1);
%     for i = 1:1:size(err,1)
%         for j=1:1:size(err,2)
%             test = [tGx(i,j) tGy(i,j)];
%             top = top + (test' * err(i,j));
%         end
%     end
   
    %find delta p
    deltaP = invHessian * top;
    %disp(deltaP);
    %if( sqrt(mean(err(:).^2)) < 0.06)
    %disp(norm(deltaP))
    if( norm(deltaP) <= 0.005)
        break;
    end
    
    p = p - deltaP;
end


u = p(1);
v = p(2);
