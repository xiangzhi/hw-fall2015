function [t] = buildTable(n,xs,fxs)


%initialize the table
t = zeros(n+1,n+1);
%reassign the first column
t(:,1) = fxs;

for i=1:n+1
    for j = i:n+1
        if j == 1
            break
        end
        up = t(j-1,i-1) - t(j,i-1);
        down = xs(j-i+1) - xs(j);
        t(j,i) = up/down;
    end
end
