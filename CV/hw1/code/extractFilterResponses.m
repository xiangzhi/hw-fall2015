function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
 


%fake the next 2 levels if its not RGB
if size(I,3)==1
    I = repmat(I,[1 1 3]);
end
%get the size
doubleI = double(I);
pixelCount = size(doubleI,1)*size(doubleI,2);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));

%Convert input Image to Lab


%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);



%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===
i = 1;
for k=1:length(filterBank)
    tmp = imfilter(L, filterBank{k});
    filterResponses(:,i) = reshape(tmp, [1,pixelCount]);
    tmp = imfilter(a, filterBank{k});
    filterResponses(:,i+1) = reshape(tmp, [1,pixelCount]);
    tmp = imfilter(b, filterBank{k});
    filterResponses(:,i+2) = reshape(tmp, [1,pixelCount]); 
    i = i + 3;
end
