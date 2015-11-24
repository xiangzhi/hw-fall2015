function [w,b] = svmSolver(data,labels,c)


H = (labels * labels').* (data * data');
%H = H.* -1;

f = ones(size(labels,1),1);
f = f.* -1;

xi = 0.00001;

cVec = ones(size(labels,1),1);
cVec = cVec.* c;
%cVec = minus(cVec,xi);
aeq = labels';
beq = 0;
lb = zeros(size(labels,1),1);
%lb = lb + xi;
Amatrix = zeros(size(labels,1),size(labels,1));
b = zeros(size(labels,1),1);

alpha = quadprog(H,f,Amatrix,b,aeq,beq,lb,cVec,[],optimset('Algorithm','interior-point-convex','Display','off'));


wp = (alpha.* labels);
w = data' * wp;

%[w1,w2] = arrayfun(@(x,y,z1,z2) deal(z1.*(x * y),z2.*(x*y)),alpha(:,1),labels(:,1),data(:,1),data(:,2));
%w = [sum(w1) sum(w2)];
%w = sum((alpha * labels')*(data));

%wx = repmat(w,size(data,1),1);

%b2 = arrayfun(@(w1,w2,x1,x2) w1 * x1 + w2 * x2, wx(:,1), wx(:,2),data(:,1), data(:,2));

b = data * w;
yt = (labels./1);
b = yt - b;
%b3 = mean(yt - b2);
b = mean(b);


%first try solve the lagrandian


%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


end

