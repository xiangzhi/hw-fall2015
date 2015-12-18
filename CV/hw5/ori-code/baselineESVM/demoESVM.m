addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
I = imread('peppers.png');
load('../../data/bus_esvm.mat');
%% orig
params = esvm_get_default_params(); %get default detection parameters
detectionBoxes = esvm_detect(I,models,params);
showboxes(I,detectionBoxes);

%% test batch
params = esvm_get_default_params(); %get default detection parameters
boxes = batchDetectImageESVM(modelImageNames,models,params);
disp('Done');

%% get ground truth box
gtBoxCell = cell(1,size(models,2));
for i=1:1:size(models,2)
    gtBoxCell{i} = models{i}.gt_box;
end


%% get AP
[rec,prec,ap] = evalAP(gtBoxCell,boxes)
disp(ap);