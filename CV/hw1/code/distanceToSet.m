function [histInter] = distanceToSet(wordHist, histograms)
%Calculate the historgram interaction between two histograms 
    %should be size independed
    maxSize = size(histograms,2);
    wordHist = repmat(wordHist,1,maxSize);
    histInter = sum(min(wordHist,histograms));
end

