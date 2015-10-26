function mask = SubtractDominantMotion(image1, image2)

    %imshow(image2);
    %M = affine_ic(image2,image1,[0 0 0;0 0 0],1000,1);
    M = LucasKanadeAffine(image1,image2);
    %mMatrix = M(end).warp_p;
    %mMatrix =[mMatrix;0 0 1];
    %mMatrix(1,1) = mMatrix(1,1)+1;
    %mMatrix(2,2) = mMatrix(2,2)+1;
    mMatrix =[M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    

    warpped = warpA(im2double(image1),mMatrix,size(image1));
    %warpped = quadtobox(im2double(image1),tmplt_pts,mMatrix,'bilinear');
    imshow(warpped);
    mask = (abs(warpped - im2double(image2))) > 0.1;
end

