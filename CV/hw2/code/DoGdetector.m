function [locs, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast,th_r)
%Combination method that runs a DoGdetection on the image using the values
%given
    GaussianPyramid = createGaussianPyramid(im, sigma0 , k , levels);
    [GaussianPyramid, levels] = createDoGPyramid(GaussianPyramid, levels);
    r = computePrincipalCurvature(GaussianPyramid);
    locs = getLocalExtrema(GaussianPyramid,levels,r,th_contrast,th_r);
end

