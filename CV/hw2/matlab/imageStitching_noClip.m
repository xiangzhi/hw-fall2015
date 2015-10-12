function [panoImg] = imageStitching_noClip(img1, img2, H2to1)


    %scaler = [0.95 0 0;0 0.95 0;0 0 1];

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

    x = 0;
    y = abs(height - yMax);
    
    
    m = [1 0 x;0 1 y;0 0 1];
    ori = warpH(img1, m,[height width]);
    warp_im = warpH(img2,m * H2to1,[height width]);
    %blend the image
    panoImg = imfuse(ori,warp_im,'blend','Scaling','joint');
end

