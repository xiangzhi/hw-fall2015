function [w,b] = svmSolver(data,labels,c)


H = (labels * labels').* (data * data');
H = H.* -1;

f = ones(size(labels,1),1);
f = f*-1;

xi = 0.00001;

cVec = ones(size(labels,1),1);
cVec = cVec.* c;
cVec = minus(cVec,xi);
aeq = labels';
beq = 0;
lb = zeros(size(labels,1),1);
lb = lb + xi;
Amatrix = zeros(size(labels,1),size(labels,1));
b = zeros(size(labels,1),1);

alpha = quadprog(H,f,Amatrix,b,aeq,beq,lb,cVec,[],optimset('Algorithm','interior-point-convex','Display','off'));

w = sum((alpha * labels')*(data));

b = w * data';
yt = (labels./1);
b = yt - b';
b = mean(b);


%first try solve the lagrandian


%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


end

