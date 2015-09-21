function [wordMap] = getVisualWords(I, filterBank, dictionary)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %create an empty world map
    %disp(size(I));
    %wordMap = zeros(size(I,1),size(I,2));

    %crate a filter response here 
    imgResponse = extractFilterResponses(I, filterBank);
    %disp(size(imgResponse));
    dict = dictionary';
    %disp(size(dict));
    D = pdist2(dict, imgResponse);
    
    %go through and pick the correct word
    %disp(size(D,2));
    tempMap = zeros(1,size(imgResponse,1));
    for i=1:size(D,2)
        [~,index] = min(D(:,i));
        %disp(D(:,i));
        tempMap(i) = index;
    end
    
    %reshapeBack to the expected size
    wordMap = reshape(tempMap,[size(I,1),size(I,2)]);
    %disp(wordMap);
    imagesc(wordMap);
end

