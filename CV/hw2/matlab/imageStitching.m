function [panoImg] = imageStitching(img1, img2, h)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    warp_im = warpH(img2,h,[1280 1280]);
    
    %img
    
    imshow(warp_im);
    %ori = warpH(img1,h,size(img1));
    %ori = zeros([1280, 1280]);
    %ori(1:size(img1,1),1:size(img1,2)) = img1;
    blend = imfuse(img1,warp_im,'blend');
    imshow(blend);
    
    %imshow(blend);
%     imshow(warp_im);
%     imshow(img1);
    %imshowpair(img1, warp_im, 'montage')
    %disp(warp_im);
end

