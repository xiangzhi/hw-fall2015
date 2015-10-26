function [u,v] = LucasKanadeBasis(It, It1, rect, bases)
%Lucus Kanade tracking of the system

height = rect(4) - rect(2) + 1;
width = rect(3) - rect(1) + 1;
%jacobian = [ones(h,w),zeros(h,w);zeros(h,w),ones(h,w)];
itX = linspace(rect(2),rect(4),height);
itY = linspace(rect(1),rect(3),width);

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
steepQ = zeros(size(template,1),size(template,2),2);
aConstant = sum(sum(bases));
hessian = zeros(2,2);
for i = 1:1:size(template,1)
    for j=1:1:size(template,2)
        g = [tGx(i,j) tGy(i,j)];
        tmp = zeros(1,2);
        for c = 1:1:size(aConstant,3)
            tmp1 = (aConstant(1,1,c) * g)*bases(i,j);
            tmp = tmp + tmp1;
        end
        t2 = g - tmp;
        steepQ(i,j,:) = g - tmp;
        t1 = (g - tmp)' * (g - tmp);
        hessian = hessian + t1;
    end
end

invHessian = inv(hessian);
p = [0;0];
while(true)
    
    %first warp the image
 
    interVectorX = linspace(rect(2) +p(2),rect(4) +p(2),height);
    interVectorY = linspace(rect(1) +p(1),rect(3) +p(1),width);
    img = interp2(im2double(It1),interVectorY',interVectorX);
    
    %compute error image
    err = img - template;
    %disp(sqrt(mean(err(:).^2)));

    %step 7 -- can do better than this
    %top = steep' * reshape(err,size(err,1)*size(err,2),1);
    top = zeros(2,1);
    for i = 1:1:size(err,1)
        for j=1:1:size(err,2)
            steep1 = reshape(steepQ(i,j,:),1,2);
            top = top + (steep1' * err(i,j));
        end
    end
   
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
