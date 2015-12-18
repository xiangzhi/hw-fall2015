function [M] = constructM(p)
%CONSTRUCTM Summary of this function goes here
%   Detailed explanation goes here

M = [p(1:3)'; p(4:6)'; 0 0 1];
M(1,1) = M(1,1) + 1;
M(2,2) = M(2,2) + 1;

end