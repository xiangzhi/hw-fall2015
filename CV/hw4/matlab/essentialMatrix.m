function [ E ] = essentialMatrix( F, K1, K2 )
% essentialMatrix:
%    F - Fundamental Matrix
%    K1 - Camera Matrix 1
%    K2 - Camera Matrix 2

E1 = K1' * F * K2;
E2 = K2' * F * K1;
E = E1;
end

