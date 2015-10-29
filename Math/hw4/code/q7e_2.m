%load the text file
id = fopen('../data/handwriting_negative_class.txt');
negativeData = dlmread('../data/handwriting_negative_class.txt',' ');
positiveData = dlmread('../data/handwriting_positive_class.txt',' ');

data = [positiveData;negativeData];
%data = [negativeData;positiveData];
labels = [ones(size(positiveData,1),1);ones(size(negativeData,1),1).* -1];
%labels = [ones(size(negativeData,1),1);ones(size(positiveData,1),1).* -1];
K = 10;
indices = crossvalind('Kfold',size(data,1), K);
save = zeros(1,784);
for i = 1:1:K
    test = (indices == i);
    train = ~test;
    %generate trainingDta
    trainData = data(train,:);
    trainLabel = labels(train,:);
    %run the SVM
    [w, b] = svmSolver(trainData,trainLabel,1);
    save = w;
    err = 0;
    testData = data(test,:);
    testLabel = labels(test,:);
    p = w * testData';
    p = p - b;
    %now check for those more than 0
    x = sum(testLabel((p > 0)) == 1) + sum(testLabel((p < 0)) == -1);
    correctP = sum(testLabel((p > 0)) == 1);
    c = p' < 0;
    test = testLabel(p' > 0);
    wrongP = sum(testLabel(p > 0) ~= 1);
    totalP = sum(testLabel == 1);
    correctN = sum(testLabel((p < 0)) == -1);
    wrongN = sum(testLabel((p < 0)) ~= -1);
    totalN = sum(testLabel == -1);
    fprintf('%d & %d & %d & %f & %d & %d & %f %f \\\\ \\hline \n', ...
        i,correctP,wrongP,correctP/totalP,correctN,wrongN,correctN/totalN,x/size(testLabel,1));
    correct = x/size(testLabel,1);
    %correct = sum(testLabel((p > 0)))/size(testLabel,1);
    %disp('correct:');
    %disp(correct);
    
end
displayImage(save);




%throw into SVM
