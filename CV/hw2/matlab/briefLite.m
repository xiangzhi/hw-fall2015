function [locs, desc] = briefLite(im)
    levels = [-1 0 1 2 3 4];
    %load patterns
    load('testPattern.mat');
    %get the description
    [locs, pyramid] = DoGdetector(im,1,sqrt(2),levels,0.03,12);
    %get the descriptrors
    [locs, desc] = computeBrief(im,locs,levels, compareX, compareY);
end

