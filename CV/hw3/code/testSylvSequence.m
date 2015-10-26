
%load the sequence
load('../data/sylvextseq.mat');
%oriRect = [60,117,146,152];
%LucasKanade(frames(:, :, 1),frames(:, :, 5),oriRect);

load('../data/sylvextbases.mat');

oriRect = [122, 59, 169, 104];
% imshow(frames(:, :, 1));
% rectangle('Position',[oriRect(1), oriRect(2), oriRect(3) - oriRect(1),oriRect(4)-oriRect(2)],...
%          'LineWidth',2)
rect = oriRect;    

%[u,v] = LucasKanadeBasis(frames(:,:,i),frames(:,:,i+1),rect,bases);

saveMat = zeros(size(frames,3),4);

for i=1:1:size(frames,3) - 1
    
    %show the image first, I guess
    %hold on
    %imshow(frames(:, :, i));
    %rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)]);
    %hold off
    
    [u,v] = LucasKanadeBasis(frames(:,:,i),frames(:,:,i+1),rect,bases);
    %[u,v] = LucasKanade(frames(:,:,i),frames(:,:,i+1),rect);
    %disp([u v]);
    rect(1) = rect(1) + u;
    rect(3) = rect(3) + u;
    rect(2) = rect(2) + v;
    rect(4) = rect(4) + v;
%     
%     if(i == 2 || i == 101 || i == 201 || i == 301 || i == 401)
%         saveas(gcf,strcat('pic',i ,'.png'));
%     end
    
    saveMat(i,:) = rect;
    disp(i);
    
%   rectangle = [rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)];
%     img = step(shapeInserter, frames(:, :, i), rectangle);
%     imshow(img);

end

disp('done');