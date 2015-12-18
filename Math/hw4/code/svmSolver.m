function [w,b] = svmSolver(data,labels,c)


H = (labels * labels').* (data * data');

f = ones(size(labels,1),1);
f = f.* -1;

xi = 0.00001;

cVec = ones(size(labels,1),1);
cVec = cVec.* c;
aeq = labels';
beq = 0;
lb = zeros(size(labels,1),1);
Amatrix = zeros(size(labels,1),size(labels,1));
b = zeros(size(labels,1),1);

alpha = quadprog(H,f,Amatrix,b,aeq,beq,lb,cVec,[],optimset('Algorithm','interior-point-convex','Display','off'));

wp = (alpha.* labels);
w = data' * wp;

%index of the points that are whin a range
idx = alpha > xi & alpha < (c - xi);

b = data(idx,:) * w;
yt = (labels./1);
b = yt(idx) - b;
b = mean(b);

end

