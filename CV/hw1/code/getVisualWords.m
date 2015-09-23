function [wordMap] = getVisualWords(I, filterBank, dictionary)
%Return a HxW matrix of the corresponding visual word for each pixel

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

