function [h] = getImageFeatures(wordMap, dictionarySize)
%Method that returns a historgram of the image features

    %generate the histogram
    h = histcounts(wordMap, dictionarySize);
    %flip the array cause it returns 1xdictionarySize instead the desired
    %dictionarySizex1
    h = h';
    %normalize h
    h = h/norm(h,1);
    %disp(h);
end

