function [curvature] = computePrincipalCurvature(DoGPyramid)
%Calculate the Principle Curvature

    mapSize = size(DoGPyramid);
    %create the curvature map
    curvature = zeros(mapSize);

    for k = 1:1:mapSize(3)
        map = DoGPyramid(:,:,k);
        [FX, FY] = gradient(map);
        [DXX, DXY] = gradient(FX);
        [DYX, DYY] = gradient(FY);
        for i = 1:1:mapSize(1)
            for j = 1:1:mapSize(2)
                H = zeros(2,2);
                H(1,1) = DXX(i,j);
                H(1,2) = DXY(i,j);
                H(2,1) = DYX(i,j);      
                H(2,2) = DYY(i,j);
                curvature(i,j,k) = trace(H).^2/det(H);
            end    
        end
    end
   
end

