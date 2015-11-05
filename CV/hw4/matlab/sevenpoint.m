function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

%normalize the points
pts1 = ((pts1.*2)./M) + -1;
pts2 = ((pts2.*2)./M) + -1;
%build the tranformation matrix
T = [2/M,0,-1;0,2/M,-1;0,0,1];

%rearrange the matrix
U = [pts1(:,1).* pts2(:,1), pts1(:,2).* pts2(:,1), pts2(:,1), ...
    pts1(:,1).* pts2(:,2), pts1(:,2).* pts2(:,2), pts2(:,2), ...
    pts1(:,1), pts1(:,2), ones(size(pts1,1),1)];

%find the solution
[u,s,v] = svd(U);
f1 = v(:,end);
f1 = reshape(f1,3,3);
f2 = v(:,end-1);
f2 = reshape(f2,3,3);

%used the symbolic toolset to
%solve for the determinent
syms x;
F1 = f1.* x;
F2 = f2.* (1-x);
eq = det(F1 + F2);
sol = solve(eq,x);
ans = double(vpa(sol));

F = cell(3,1);

for i=1:1:size(ans,1)
    f = f1.*ans(i) + f2.*(1-ans(i));
    F{i} = T' * f *T;
end



% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

end

