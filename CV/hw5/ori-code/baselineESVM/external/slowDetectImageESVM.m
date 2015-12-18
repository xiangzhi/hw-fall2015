function [boundingBoxes] = slowDetectImageESVM(imageNames, models, params)
%some codes are taken from hw1 


boundingBoxes = cell(1,size(imageNames,2));
for i=1:1:size(imageNames,2)
    disp(i);
    I = imread(strcat('../../data/voc2007/',char(imageNames(1,i))));
    boundingBoxes{1,i} = esvm_detect(I,models,params);
end
end

