
%load the sequence
load('../data/carseq.mat');
%oriRect = [60,117,146,152];
%LucasKanade(frames(:, :, 1),frames(:, :, 5),oriRect);


hold on
oriRect = [60,117,146,152];
% imshow(frames(:, :, 1));
% rectangle('Position',[oriRect(1), oriRect(2), oriRect(3) - oriRect(1),oriRect(4)-oriRect(2)],...
%          'LineWidth',2)

rect = oriRect;    
for i=2:1:size(frames,3)
    [u,v] = LucasKanade(frames(:,:,i-1),frames(:,:,i),rect);
    rect(1) = rect(1) + u;
    rect(3) = rect(3) + u;
    rect(2) = rect(2) + v;
    rect(4) = rect(4) + v;
    hold on
    imshow(frames(:, :, i));
    rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)],...
         'LineWidth',2)
    hold off
end
disp('done');