function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)
%creates a DoG Pyramid
  
    pyramidSize = size(GaussianPyramid);
    levelNum = pyramidSize(3);
  
    for i = levelNum:-1:2
        GaussianPyramid(:,:,i) = GaussianPyramid(:,:,i) - GaussianPyramid(:,:,i-1);
    end
    DoGPyramid = GaussianPyramid(:,:,2:levelNum);
    DoGLevels = levels(2:levelNum);
    
    
end

