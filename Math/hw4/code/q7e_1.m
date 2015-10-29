

%load the text file
id = fopen('../data/2d_negative_class.txt');
tmp = textscan(id,'%f %f');
negativeData = zeros(size(tmp{1},1),2);
negativeData(:,1) = tmp{1};
negativeData(:,2) = tmp{2};
id = fopen('../data/2d_positive_class.txt');
tmp = textscan(id,'%f %f');
positiveData = zeros(size(tmp{1},1),2);
positiveData(:,1) = tmp{1};
positiveData(:,2) = tmp{2};

data = [positiveData;negativeData];
labels = [ones(size(positiveData,1),1);ones(size(negativeData,1),1).* -1];
[w, b] = svmSolver(data,labels,0.01);
disp(w);

hold on
scatter(positiveData(:,1),positiveData(:,2),'+');
scatter(negativeData(:,1),negativeData(:,2),'o');
syms x y
ezplot(w(1)*x + w(2) * y + b == 1);
ezplot(w(1)*x + w(2) * y + b == 0);
ezplot(w(1)*x + w(2) * y + b == -1);

hold off



%solve the minimization problem