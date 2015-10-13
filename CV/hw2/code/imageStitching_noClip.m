function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%blend img1 and im2 together by projecting img2 to img1 space with H2to1.
%Also deals with clipping issue by rearranging the image and expanding the
%width and height.

    img2Size = size(img2);
    corners = [0 0 img2Size(2) img2Size(2);0 img2Size(1) 0 img2Size(1); 1 1 1 1];
    %this will give us the warpped corners
    warpped = H2to1 * corners;
    %make (3,3) = 1;
    warpped(:,2) = warpped(:,2)/warpped(3,2);
    warpped(:,3) = warpped(:,3)/warpped(3,3);
    warpped(:,4) = warpped(:,4)/warpped(3,4);
    corners = [corners warpped];
    xMin = min(min(corners(1,:)));
    xMax = max(max(corners(1,:)));
    yMin = min(min(corners(2,:)));
    yMax = max(max(corners(2,:)));
    %given width
    width = ceil(abs(xMin) + abs(xMax));
    height = ceil(abs(yMin) + abs(yMax));
    
    x = abs(width - xMax);
    y = abs(height - yMax);
    
    m = [1 0 x;0 1 y;0 0 1];
    ori = warpH(img1, m,[height width]);
    warp_im = warpH(img2,m * H2to1,[height width]);
    %blend the images
    in = ori(:,:,1:3) == 0;
    ori(in) = warp_im(in);
    panoImg = ori;
end

