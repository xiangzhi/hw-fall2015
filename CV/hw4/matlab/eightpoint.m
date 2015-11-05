function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

%normalize the points
pts1 = ((pts1.*2)./M) + -1;
pts2 = ((pts2.*2)./M) + -1;

%rearrange the matrix
U = [pts1(:,1).* pts2(:,1), pts1(:,2).* pts2(:,1), pts2(:,1), ...
    pts1(:,1).* pts2(:,2), pts1(:,2).* pts2(:,2), pts2(:,2), ...
    pts1(:,1), pts1(:,2), ones(size(pts1,1),1)];

%find the solution
[u,s,v] = svd(U);
f = v(:,end);
f = reshape(f,3,3);

%enforce singularity by decomposing and setting the diagonal to 0.
[u,s,v] = svd(f);
s(3,3) = 0;
F = u * s * v';
%build the tranformation matrix
T = [2/M,0,-1;0,2/M,-1;0,0,1];
%unscale the F
F = T' * F * T;

end

