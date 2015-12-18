function [desc] = computeBRIEF(im, patchWidth, nbits)
%Uses the BRIEF descriptor that was used in HW2
%Used G1 method in the paper which a uniform distirbution


%image
im = im2double(rgb2gray(im));
%to store the descriptor.
desc = zeros(1,patchWidth);

%create the number of compares
for i=1:1:nbits
    %randomly find the starting point
    startX = randi([1, patchWidth]);
    startY = randi([1, patchWidth]);
    %randomly find the ending points
    endX = randi([1,patchWidth]);
    endY = randi([1,patchWidth]);
    %store the linear indecis

    if im(startY, startX) < im(endY,endX)
        desc(1,i) = 1;
    else
        desc(1,i) = 0;
    end
end

end

