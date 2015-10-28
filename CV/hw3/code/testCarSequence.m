%script to test the performance of the car sequence

%load the sequence
load('../data/carseq.mat');
%set the initial rectangle
rect = [60,117,146,152];    
%create a matrix to save the values as it loops through
rects = zeros(size(frames,3),4);
%loop through all the frames
for i=1:1:size(frames,3) - 1
    
    %show the image first, I guess
    hold on
    imshow(frames(:, :, i));
    title(strcat('frame ',num2str(i)));
    rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)]);
    hold off
    
    [u,v] = LucasKanade(frames(:,:,i),frames(:,:,i+1),rect);
    %update the rectangle by u and v
    rect(1) = rect(1) + u;
    rect(3) = rect(3) + u;
    rect(2) = rect(2) + v;
    rect(4) = rect(4) + v;
    %at the required frames, stop and save the image
    if(i == 1 || i == 100 || i == 200 || i == 300 || i == 400)
        saveas(gcf,strcat('../figures/fig-1-3-',num2str(i),'.png'));
    end
    %save the rectangle in the matrix
    rects(i,:) = rect;
    disp(i);
end

save('carseqrects.mat','rects');

disp('done');