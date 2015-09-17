function [R,T] = pointSolver(i,o)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

curMat = eye(3);

%find the center of the problem
cI = [0,0,0]';
cO = [0,0,0]';
for k=1:length(i)
    cI = cI + (1/length(i)) * i{k};
    cO = cO + (1/length(o)) * o{k};
end
A = [];
B = [];
for k=1:length(i)
    A = [A i{k} - cI];
    B = [B o{k} - cO];
end
m = B * A';
disp(m);
[U,S,V] = svd(m);
%mid = diag([1 1 det(U*V')]);
R = U * V';
%R = U * mid * V';
disp(R);
T = cO - R*cI

end

