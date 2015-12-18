addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
addpath(genpath('../external'));
addpath(genpath('./external'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');

filterBank = createFilterBank();
selection = 0.1;
pixelSelect = randperm(100 * 100,100 * 100 * selection);
data = zeros(size(models,2), 100 * 100 * selection * 60); % each row will have 100 x 100 x 3 x 20 filter bank responses

resizedImgs = cell(size(modelImageNames,2),1);
%% get the image of all the exemplers
for i=1:1:size(modelImageNames,2)
    boundingBoxt = models{i}.gt_box;
    boundingBox = modelBoxes{i};
    %get image
    img = imread(strcat('../../data/voc2007/',char(modelImageNames{i})));
    boundedImg = img(boundingBox(2):boundingBox(4), boundingBox(1):boundingBox(3),:);
    % now we reshape the image to 100x100
    resizedImgs{i} = imresize(boundedImg,[100 100]);
    %apply the filterbank on it
    filtered = extractFilterResponses(resizedImgs{i}, filterBank);
    filtered = filtered(pixelSelect,:); % only select some random pixels.
    data(i,:) = reshape(filtered,1, prod(size(filtered)));
    %disp(i);
end
   
%% apply kmeans

k = [5,10,20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250];
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


%% run test on the selected models
params = esvm_get_default_params(); %get default detection parameters
%params.detect_levels_per_octave = 3;
boxes = batchDetectImageESVM(gtImages,pickedmodel,params);
[~,~,aps(j)] = evalAP(gtBoxes,boxes);

disp(sprintf('ap:%f k:%d',aps(j),k(j)));

end

%% uncomment the following if you want to see the image.

% %% display the resulting images
% k = 110;
% [idx,C,~,distance] = kmeans(data,k);
% imgs = zeros(100,100,3,k);
% for i=1:1:size(idx,1)
%     %if the imgs is still empty
%     if sum(sum(sum(imgs(:,:,:,idx(i))))) == 0
%         imgs(:,:,:,idx(i)) = im2double(resizedImgs{i});
%     else
%         imgs(:,:,:,idx(i)) = (im2double(resizedImgs{i}) + imgs(:,:,:,idx(i)))./2;
%     end
%     disp(i);
% end
% 
% imdisp(imgs);



