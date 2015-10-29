function image = displayImage(I,gray)
% This function takes a vector from the handwriting dataset and displays it
% as an image.  You can change whether the image is grayscale or not using
% the second input paramter.  Default is gray.

if nargin < 2
    gray = true;
end

if numel(I) ~= 784
    error('Error: vector not from a 28x28 pixel image.  Wrong number of dimensions.')
end

image = reshape(I,28,28);
imagesc(image);
if gray
    colormap('gray')
else
    colormap('default')
end
