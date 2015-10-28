%to test the subtract dominant motion

%load the image
load('../data/aerialseq.mat');

%matrix to save masks
masks = zeros(size(frames));

%loop through all the frames
for i=1:1:size(frames,3) - 1
    %find the mask
    mask = SubtractDominantMotion(frames(:,:,i),frames(:,:,i+1));
    %color and merge the image
    rgbImage = repmat(double(frames(:,:,i))./255,[1 1 3]);
    for j = 1:size(mask,1)
        for k = 1:size(mask,2)
            if mask(j,k) == 1
                rgbImage(j,k,:) = [2 0 0];
            end
        end
    end
    %save the mask
    masks(:,:,i) = mask;
    
    %display the output
    title(strcat('frame:',num2str(i)));
    imshow(rgbImage);
    %save individual images
    if(i == 30 || i == 60 || i == 90 || i == 120)
        saveas(gcf,strcat('../figures/fig-3-3-',num2str(i),'.jpg'));
    end
end
save('aerialseqmasks.mat','masks');