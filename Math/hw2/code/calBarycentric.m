function [alpha] = calBarycentric(p,p1, p2, p3)
    %calculate the alpha by solving the Linear Equation of the three triangles
    A = [p1(1,1) p2(1,1),p3(1,1);p1(1,2) p2(1,2) p3(1,2);1 1 1];
    %disp(A);
    B = [p(1,1);p(1,2);1];
    %disp(B);
    [u s v] = svd(A);
    s(1,1) = 1/s(1,1);
    s(2,2) = 1/s(2,2);
    s(3,3) = 1/s(3,3);
    alpha = v * s * u' * B;
    
    
    
end


