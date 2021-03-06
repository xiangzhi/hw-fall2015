function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
%Get the Image Feature vector through Spatial Pyramid Matching

    %create all the smaller maps
    smallerWordMap = {wordMap};
    %first split the image into smaller pieces 
    smallerWordMap = splitImage(smallerWordMap,layerNum);
    %calculate the historgram at each step
    %TODO: we might can merge these two methods
    histCellMap = calHistogram(smallerWordMap, dictionarySize);
    %now calculate the grand value
    h = findCombineHistorgram( histCellMap,0,layerNum,dictionarySize);
    %h = [1 2];
end

