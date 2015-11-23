function [p,l,d,u] = test(a)
% first get the size of the matrix, since we don't know it
mSize = size(a);
rowNum = mSize(1);
colNum = mSize(2);
%fprintf( 'colNum:%d, rowNum:%d\n', colNum, rowNum);
% initialize all variables
a_ = a;
l = eye(colNum, rowNum);
p = eye(colNum, rowNum);
baseRow = 1;
baseCol = 1;
% seperate into L and DU
for col = 1:1:colNum
    for i = baseRow+1:1:rowNum
        %check if the current element is a zero
        disp(a_(baseRow,baseCol));
        if a_(baseRow,baseCol) == 0
            %find the next non-zero?
            %interchange row
            a_([baseRow baseRow+1],:) = a_([baseRow+1 baseRow],:);
            %also flip the P matrix
            p([baseRow baseRow+1],:) = p([baseRow+1 baseRow],:);
            %also flip those in L matrix
            cols = baseCol - 1;
            l([baseRow baseRow+1],1:cols) = l([baseRow+1 baseRow],1:cols);
            fprintf( 'in if case\n');
            continue;
        end
        k = a_(i,baseCol)/a_(baseRow,baseCol);
        %disp(k);
        a_(i,:) = a_(i,:) - (k * a_(baseRow,:));
        l(i,baseCol) = k;
    end
    baseRow = baseRow + 1;
    baseCol = baseCol + 1;
end
disp(p);
disp(l);
% further seperate into DU
% D is basically just the diagonal 
d = diag(diag(a_));
disp(d);
% inverse of D is easy to find since its 1/element
% there should be any 0 in between
%invD = eye(3)/d;
invD = inv(d);
u = invD * a_;
disp(u);
end