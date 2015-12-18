function [warp_im] = affine_warp(im, output_size, M)
%AFFINE_WARP Summary of this function goes here
%   Detailed explanation goes here

% get all of the points in the output image that will be sampled with
% interp2
[X,Y] = meshgrid(1:output_size(2), 1:output_size(1));
xy = [reshape(X, numel(X),1)'; reshape(Y,numel(Y),1)'];
xy = [xy; ones(1,size(xy,2))];

% transform these points into the source
% if we go from source to destination then there will be holes in the image
% see homework 0
uv = M*xy;
uv = uv(1:2,:)';

% reshape these points back into a meshgrid so that interp2 will work
X = reshape(uv(:,1), output_size(1), output_size(2));
Y = reshape(uv(:,2), output_size(1), output_size(2));

% perform the interpolation
warp_im = interp2(im, X, Y);

% Some of the points may be NaN
% set these points to 0 (i.e. black)
warp_im(isnan(warp_im)) = 0;

end

