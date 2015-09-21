


%Constants
dictionarySize = 300;
L = 2 ;
%load the relavent files
load('../dat/traintest.mat','train_imagenames','train_labels','mapping');
load('dictionary.mat','filterBank','dictionary');
%disp(mapping);

%TODO: make it constant
train_features = zeros(dictionarySize * (4.^(L+1) - 1)/3, length(train_imagenames));
disp(size(train_features));
%train all features
for i=1:length(train_imagenames)
    %disp(train_imagenames{i});
    load(['../dat/',strrep(train_imagenames{i},'.jpg','.mat')],'wordMap');
    features = getImageFeaturesSPM(L, wordMap, dictionarySize);
    train_features(:,i) = features;
end

save('vision.mat','filterBank','dictionary','train_features','train_labels'); 

