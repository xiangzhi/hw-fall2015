%% setting path and load model
addpath(genpath('../utils'));
addpath(genpath('../lib/dpm'));
load('../../data/bus_dpm.mat');

%% Object detection via DPMs
%I = imread('q42_test.jpg');
I = imread('q42_3.jpg');
detectionBoxes = imgdetect(I,model);
figure; showboxes(I,  detectionBoxes);      %% show detected bounding boxes.

%% Non-Maximum suppression
bestBBox = nms(detectionBoxes,200,4);
figure; hold on; image(I); axis ij; hold on;
showboxes(I,  bestBBox);