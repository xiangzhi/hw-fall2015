function [output,hValues] = findCombineHistorgram(histMap,layer,maxLayer, dictionarySize)
%combines each historgram at different level 

    weight = 1/4;
    if layer > 1
        weight = 2.^(layer - maxLayer-1);
    end

    %base case where histMap is actually an hist
    if ~iscell(histMap)
        %apply weight here
        output = weight * histMap;
        %calculate the values 
        hValues = histMap;
        return;
    end
    
    %the weird case where there is only one cell
    if size(histMap,1) == 1 && size(histMap,2) == 1
        %calculate the weight here
        
        %apply the hValues, actually not sureful
        hValues = histMap{1,1};
        %calculate the output based on weight
        output = weight * histMap{1,1};
        return;
    end
    
    %the loop case
    %initialize the histgram
    hValues = zeros([dictionarySize,1]);
    output = [];
    for i = 1:size(histMap,1)
        for j = 1:size(histMap,2)
            %get the combined values at the lower level and also their hist
            [pastOut,tmp] = findCombineHistorgram(histMap{i,j},layer + 1,maxLayer,dictionarySize);
            %combine the hValues to find the higher values
            hValues = hValues + tmp;
            pastOut = pastOut * weight;
            output = [output;pastOut];
        end
    end
    
    %calculate the weight here
    %apply it to hValues
    hValues = hValues * weight;
    %add it to the output
    output = [hValues;output];
end

