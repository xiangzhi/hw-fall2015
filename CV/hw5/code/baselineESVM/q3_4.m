addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');

filterBank = createFilterBank();

data = zeros(size(models,2), 100 * 100 * 60); % each row will have 100 x 100 x 3 x 20 filter bank responses
resizedImgs = cell(size(modelImageNames,2),1);
%% get the image of all the exemplers
for i=1:1:size(modelImageNames,2)
    boundingBox = modelBoxes{i};
    %get image
    img = imread(strcat('../../data/voc2007/',char(modelImageNames{i})));
    boundedImg = img(boundingBox(2):boundingBox(4), boundingBox(1):boundingBox(3),:);
    % now we reshape the image to 100x100
    resizedImgs{i} = imresize(boundedImg,[100 100]);
    %apply the filterbank on it
    filtered = extractFilterResponses(resizedImgs{i}, filterBank);
    data(i,:) = reshape(filtered,1, prod(size(filtered)));
    disp(i);
end
   
%% apply kmeans

k = [10,20,30,40,50,60,70,80,90,100];
aps = zeros(size(k));

for j=1:1:size(k,2)

disp(sprintf('starting kmeans with k=%d',k(j)));
[idx,C,~,distance] = kmeans(data,k(j));
disp('done');

%% picking exampler based on how close to centroid
pickedmodel = cell(1,k(j));
%find all the closes models
kc = knnsearch(data,C);
pickedmodel = models(kc);

% %% pick distance
% [M, I] = min(distance);
% disp(I);

%% display the resulting images

% imgs = zeros(100,100,3,k);
% for i=1:1:size(idx,1)
%     %if the imgs is still empty
%     if sum(sum(sum(imgs(:,:,:,idx(i))))) == 0
%         imgs(:,:,:,idx(i)) = im2double(resizedImgs{i});
%         %imshow(imgs(:,:,:,idx(i)));
%     else
%         %imshow(resizedImgs{i});
%         %imshow(imgs(:,:,:,idx(i)));
%         imgs(:,:,:,idx(i)) = (im2double(resizedImgs{i}) + imgs(:,:,:,idx(i)))./2;
%     end
%     disp(i);
% end
% 
% imdisp(imgs);

%% run test on the selected models
params = esvm_get_default_params(); %get default detection parameters
%params.detect_levels_per_octave = 3;
boxes = batchDetectImageESVM(gtImages,pickedmodel,params);
[~,~,aps(j)] = evalAP(gtBoxes,boxes);

disp(sprintf('ap:%f k:%d',aps(j),k(j)));

end
%[~,~,ap] = evalAP(gtBoxes,boxes);

