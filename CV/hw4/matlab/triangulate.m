function [ P, error ] = triangulate( M1, p1, M2, p2 )
% triangulate:
%       M1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       M2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

P = zeros(size(p1,1),3);

for i=1:1:size(p2,1)
    A = [p1(i,1) * M1(3,:) - M1(1,:); ...
         p1(i,2) * M1(3,:) - M1(2,:); ...
         p2(i,1) * M2(3,:) - M2(1,:); ...
         p2(i,2) * M2(3,:) - M2(2,:)];
    
    [u,s,v] = svd(A); 
    normV = v(:,end)./v(4,end);
    P(i,:) = normV(1:3)';
end

%check error
err = 0;
for i=1:1:size(p2,1)
    tp1 = M1 * [P(i,:)';1];
    tp1 = tp1./tp1(3);
    tp2 = M2 * [P(i,:)';1];
    tp2 = tp2./tp2(3);
    err = err + norm(p1(i) - tp1) + norm(p2(i) - tp2);
end
disp(err);





% Q2.4 - Todo:
%       Implement a triangulation algorithm to compute the 3d locations
%       See Szeliski Chapter 7 for ideas
%


end

