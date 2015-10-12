function [compareX, compareY] = makeTestPattern(patchWidth, nbits)
%make test patterns
%   we use the G1 method

compareX = zeros(nbits,1);
compareY = zeros(nbits,1);

for i=1:1:nbits
    %randomly find the starting point
    startX = randi([1, patchWidth]);
    startY = randi([1, patchWidth]);
    %randomly find the ending points
    endX = randi([1,patchWidth]);
    endY = randi([1,patchWidth]);
    %store the linear indecis
    compareX(i) = sub2ind([patchWidth patchWidth], startX, endX);
    compareY(i) = sub2ind([patchWidth patchWidth], startY, endY);
    %compareX(1) = [startX endX];
    %compareY(1) = [startY endY];
end



end

