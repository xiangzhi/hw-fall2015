function [panoImg] = imageStitching(img1, img2, h)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    warp_im = warpH(img2,h,[1280 2000]);
    %blend the image
    panoImg = imfuse(img1,warp_im,'blend','Scaling','joint');
end

