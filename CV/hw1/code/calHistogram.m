function histCell = calHistogram(input, dictionarySize)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    % the base case where the input is not a cell
    if ~iscell(input)
        histCell = getImageFeatures(input,dictionarySize);
        return;
    end 
    
    %the recursive case where we going through multiple units
    histCell = cell(size(input,1),size(input,2));
    for i = 1:size(input,1)
        for j = 1:size(input,2)
            histCell{i,j} = calHistogram(input{i,j},dictionarySize);
        end
    end
end

