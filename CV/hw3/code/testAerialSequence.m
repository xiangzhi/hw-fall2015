load('../data/aerialseq.mat');

for i=1:1:size(frames,3) - 1
    mask = SubtractDominantMotion(frames(:,:,i),frames(:,:,i+1)); 
end

disp('done');