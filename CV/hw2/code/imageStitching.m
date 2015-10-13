function [panoImg] = imageStitching(img1, img2, h)
%combine two images img1 and img2 by projecting img2 to the img1 space with
%h
    warp_im = warpH(img2,h,[1280 2000]);
    %blend the image
    warp_im(1:size(img1,1),1:size(img1,2),:) = img1;
    panoImg = warp_im;
end

