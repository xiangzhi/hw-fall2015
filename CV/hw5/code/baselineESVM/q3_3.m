addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
load('../../data/bus_esvm.mat');

%% test batch
load('../../data/bus_data.mat');
params = esvm_get_default_params(); %get default detection parameters
changes = [3,5,10];
aps = zeros(size(changes));
for i=1:1:size(changes,2)
    params.detect_levels_per_octave = changes(i);
    boxes = batchDetectImageESVM(gtImages,models,params);
    disp('Done');
    %get AP
    [~,~,aps(i)] = evalAP(gtBoxes,boxes);
end

plot(changes,aps);
