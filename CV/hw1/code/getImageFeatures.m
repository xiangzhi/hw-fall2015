function [h] = getImageFeatures(wordMap, dictionarySize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %vectorize the wordMap(don't seem to need it)
    %vecWordMap = reshape(wordMap,[1,numel(wordMap)]);
    %generate the histogram
    %h = histogram(wordMap,dictionarySize);
    h = histcounts(wordMap, dictionarySize);
    %flip the array cause it returns 1xdictionarySize instead the desired
    %dictionarySizex1
    h = h';
    %normalize h
    h = h/norm(h,1);
    %disp(h);
end

