function [P] = triangulate_t( M1, p1, M2, p2 )
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
    %normV = v(:,end)./v(4,end);
   %P(i,:) = normV(1:3)';
   P(i,:) = v(1:3,end);
end

end

