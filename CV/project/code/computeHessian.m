function [H] = computeHessian(sdImages, numParams, width)
%COMPUTEHESSION Summary of this function goes here
%   Detailed explanation goes here

H = zeros(numParams);
% want to compute sdImage'*sdImage
% for each pixel and then sum up
% Can instead reverse the order and do element wise multiplication
% and summation
for i=1:numParams
    temp1 = sdImages(:, (i-1)*width+1:((i-1) + 1)*width);
    for j=1:numParams
        temp2 = sdImages(:, (j-1)*width+1:((j-1)+1)*width);
        H(i, j) = sum(sum((temp1.*temp2)));
    end

end

