function mask = SubtractDominantMotion(image1, image2)
%returns a binary mask of the difference of two images
%based on the motion
    %apply the lucas kanade affine transform
    M = LucasKanadeAffine(image1,image2);
    %build the matrix
    mMatrix =[M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    %set the matrix up
    warpped = warpA(im2double(image1),mMatrix,size(image1));
    %generate the mask
    mask = (abs(warpped) - abs(im2double(image2))) > 0.2;
end

