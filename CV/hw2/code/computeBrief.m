function [locs,desc] = computeBrief(im, locs, levels, compareX, compareY)
%implementation of the BRIEF algorithm. Returns the location of matches and
%with the corresponding discriptors.

    %firstly figure out how many locs are valid, the must be more than 3 on
    %each side
    disp(size(locs));
    imageSize = size(im);
    xs = locs(:,1);
    ys = locs(:,2);
    idx = (xs > 4) & (ys > 4) & (xs < imageSize(2) - 3) &  (ys < imageSize(1) - 3); %check for size restriction
    locs = locs(idx,:);
    disp(size(locs));
    
    desc = zeros(size(locs,1),size(compareX,1));
    
    %loop through all the locs
    for i=1:1:size(locs)
        %get the patch
        patch = im(locs(i,2)-4:locs(i,2)+4,locs(i,1)-4:locs(i,1)+4);
        for k=1:1:256
            [startX, endX] = ind2sub([9 9],compareX(k));
            [startY, endY] = ind2sub([9 9],compareY(k));
            %calculate the binary
            if patch(startY, startX) < patch(endY,endX)
                desc(i,k) = 1;
            else
                desc(i,k) = 0;
            end
        end
    end
end

