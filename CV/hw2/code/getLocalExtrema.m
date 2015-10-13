function [ locs ] = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)
%find the local extram's by looping through all the points and levels.

    pyramidSize = size(DoGPyramid);
    width = pyramidSize(1);
    height = pyramidSize(2);
    numLevel = pyramidSize(3);
    locs = zeros(10,3);
    index = 1;
    %loop through all the levels
    for l = 1:1:numLevel
        %loop through the whole image.
        for i = 1:1:width
            for j = 1:1:height
                %check
                if PrincipalCurvature(i,j,l) > th_r
                    continue
                end
                
                area = DoGPyramid(max([1,i-1]):min([i+1,width]),max([1,j-1]):min([height,j+1]),max([1,l-1]):min([l+1,numLevel]));
                if min(min(min(area))) == DoGPyramid(i,j,l) && abs(DoGPyramid(i,j,l)) > th_contrast
                    locs(index,1) = j;
                    locs(index,2) = i;
                    locs(index,3) = l;
                    index = index + 1;
                end
                if max(max(max(area))) == DoGPyramid(i,j,l) && abs(DoGPyramid(i,j,l)) > th_contrast
                    locs(index,1) = j;
                    locs(index,2) = i;
                    locs(index,3) = l;
                    index = index + 1;
                end
            end
        end
    end
end

