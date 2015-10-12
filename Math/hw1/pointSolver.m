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
p = [];
q = [];
for k=1:length(i)
    p = [p i{k} - cI];
    q = [q o{k} - cO];
end
%create the H matrix
H = q * p';
[U,S,V] = svd(H);
R = U * V';
T = cO - R*cI
end

