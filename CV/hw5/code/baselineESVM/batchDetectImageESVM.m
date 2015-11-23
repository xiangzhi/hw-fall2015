function [boundingBoxes] = batchDetectImageESVM(imageNames, models, params)
%some codes are taken from hw1 

% Close the pools, if any
try
    fprintf('Closing any pools...\n');
%     matlabpool close; 
    delete(gcp('nocreate'))
catch ME
    disp(ME.message);
end



boundingBoxes = cell(1,size(imageNames,2));
parfor i=1:1:size(imageNames,2)
    disp(i);
    I = imread(strcat('../../data/voc2007/',char(imageNames(1,i))));
    boundingBoxes{1,i} = esvm_detect(I,models,params);
end
end

