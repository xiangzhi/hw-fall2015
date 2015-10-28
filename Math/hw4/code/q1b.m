%question 1b


y = -1;
n = 0;

%the given function
eq = @(x,y) 2/(x.^2 * (1 - y));

eq2 = @(x) x - sqrt(-x^2 + x^2 + 4 * x)/x

%Euler Method
for i=1:-0.05:0
    fy = eq(i,y);
    fprintf('n:%d x:%f y:%f\n',n,i,y);
    y = y + (-0.05)*fy;
    n = n + 1;
end