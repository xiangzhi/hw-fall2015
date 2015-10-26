load('../data/aerialseq.mat');

for i=1:1:size(frames,3) - 1
    mask = SubtractDominantMotion(frames(:,:,i),frames(:,:,i+1));
    
    rgbImage = repmat(double(frames(:,:,i))./255,[1 1 3]);
    for j = 1:size(mask,1)
        for k = 1:size(mask,2)
            if mask(j,k) == 1
                rgbImage(j,k,:) = [2 0 0];
            end
        end
    end
    imshow(rgbImage);

    
end

disp('done');