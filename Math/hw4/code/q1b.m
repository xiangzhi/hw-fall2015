%question 1b


y = -1;
n = 0;

%the given function
eq = @(x,y) 2/(x.^2 * (1 - y));

eq2 = @(x) 1 - 2 * sqrt(1/x);

%Euler Method
for i=1:-0.05:0
    fy = eq(i,y);
    %fprintf('n:%d x:%f y:%f r:%f \n',n,i,y,eq2(i));
    fprintf('%d & %f & %f & %f \\\\ \\hline \n',n,i,y,eq2(i));
    y = y + (-0.05)*fy;
    n = n + 1;
end
