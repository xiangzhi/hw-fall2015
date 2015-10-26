function mask = SubtractDominantMotion(image1, image2)

    M = LucasKanadeAffine(image1,image2);
    warpped = zeros(size(image1));
    for i =1:1:size(image1,1)
        for j=1:1:size(image1,2)
            tmp = M * [j;i;1];
            warpped = image1(tmp(2),tmp(1));
        end 
    end
    mask = image2 - warpped;
end

