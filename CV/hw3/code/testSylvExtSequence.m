
%load the sequence
load('../data/sylvextseq.mat');
%load the bases
load('../data/sylvextbases.mat');
%set the original rectangle
rect = [122, 59, 169, 104];
%create rectangle for the first algorithm
oriRect = rect;
%initialize matrix to the save the rects
rects = zeros(size(frames,3),4);

for i=1:1:size(frames,3) - 1
    %calculate the basis version of lucas kanade
    [u,v] = LucasKanadeBasis(frames(:,:,i),frames(:,:,i+1),rect,bases);
    rect(1) = rect(1) + u;
    rect(3) = rect(3) + u;
    rect(2) = rect(2) + v;
    rect(4) = rect(4) + v;
    %calculate the original lucas kanade
    [ou,ov] = LucasKanade(frames(:,:,i),frames(:,:,i+1),oriRect);
    oriRect(1) = oriRect(1) + ou;
    oriRect(3) = oriRect(3) + ou;
    oriRect(2) = oriRect(2) + ov;
    oriRect(4) = oriRect(4) + ov;
    
    %show the image , I guess
    hold on
    imshow(frames(:, :, i));
    title(strcat('frame:',num2str(i)));
    rectangle('Position',[oriRect(1), oriRect(2), oriRect(3) - oriRect(1),oriRect(4)-oriRect(2)],...
        'EdgeColor',[0 1 0]);
    rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)],...
        'EdgeColor',[1 0 0]);
    hold off
    
    if(i == 1 || i == 300 || i == 600 || i == 900 || i == 1100 || i == 1200)
        saveas(gcf,strcat('../figures/fig-2-1-',num2str(i),'.png'));
    end
    
    disp(i);
end
save('sylvseqextrects.mat','rects');