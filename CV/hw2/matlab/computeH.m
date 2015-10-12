function [H2to1] = computeH(p1,p2)
    %create the A matrix    
    %mSize = size(p1,2)*2
    mSize = size(p1,2)*2;
    A = zeros(mSize,9);
    a = 1;
    for i=1:1:mSize/2
        A(a,:) = [-1*p2(1,i) -1*p2(2,i) -1 0 0 0 p2(1,i)*p1(1,i) p2(2,i)*p1(1,i) p1(1,i)];
        A(a+1,:) = [0 0 0 -1*p2(1,i) -1*p2(2,i) -1 p2(1,i)*p1(2,i) p2(2,i)*p1(2,i) p1(2,i)];
        a = a + 2;
    end
    [u,s,v] = svd(A' * A,0);
    H2to1 = v(:,9);
    H2to1 = reshape(H2to1,[3 3]);
    H2to1 = H2to1';
    %normalize it?
    H2to1 = H2to1./H2to1(3,3);
end

