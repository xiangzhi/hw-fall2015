function [a,b,c,d] = planeSolver(points)
%Solve the plane equation with the given points
    A = ones(size(points,1),4);
    A(:,1:3) = points;
    [u,s,v] = svd(A'*A);
    sol = v(:,end);
    a = sol(1);
    b = sol(2);
    c = sol(3);
    d = sol(4);
end

