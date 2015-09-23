%script to evaluate vision.mat

load('../dat/traintest.mat','test_imagenames','test_labels');
load('vision.mat','filterBank','dictionary','train_features','train_labels'); 

cMat = zeros([8,8]);
disp(cMat);
for i = 1:length(test_imagenames)
    image = im2double(imread(['../dat/',test_imagenames{i}]));
    % imshow(image);
    %fprintf('[Getting Visual Words..]\n');
    wordMap = getVisualWords(image, filterBank, dictionary);
    h = getImageFeaturesSPM( 2, wordMap, size(dictionary,2));
    distances = distanceToSet(h, train_features);
    [~,nnI] = max(distances);
    load('../dat/traintest.mat','mapping');
    guessedImage = mapping{train_labels(nnI)};
    truth = mapping{test_labels(i)};
    fprintf('[My Guess]:%s. [TRUTH:]%s\n',guessedImage, truth);
    cMat(test_labels(i),train_labels(nnI)) = cMat(test_labels(i),train_labels(nnI)) + 1;
end
disp(cMat);
imagesc(cMat);
accuracy = trace(cMat) / sum(cMat(:));
disp(accuracy);

