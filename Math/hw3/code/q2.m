%question 2
id = fopen('data/problem2.txt');
data = textscan(id,'%f');
data = data{1,1};

p1 = data(1:51);
p2 = data(52:101);
xr1 = linspace(0,5,51);
xr2 = linspace(5.1,10,50);

hold on
plot([xr1 xr2],data);

%fit p1
phi1 = ones(size(xr1,2),1);
phi2 = xr1';
phi3 = xr1'.^2;
phi4 = xr1'.^3;
combineMat = [phi1 phi2 phi3 phi4];
[u,s,v] = svd(combineMat);
%flip the diagonal values
ds = diag(s);
ds = ds.\1;
s(logical(eye(size(s)))) = ds;
%calculate svd solution
sol = v * s' * u' * p1;
disp(sol);
syms x1
f1 = symfun(sol(1) + sol(2)*x1 + sol(3)*x1.^2 + sol(4)*x1.^3,x1);
plot(xr1,f1(xr1));
y1 = arrayfun(matlabFunction(f1),xr1);
disp(sum(abs(y1'-p1)));

%fit p2
phi1 = ones(size(xr2,2),1);
phi2 = xr2';
phi3 = xr2'.^2;
phi4 = xr2'.^3;
combineMat = [phi1 phi2 phi3 phi4];
[u,s,v] = svd(combineMat);
%flip the diagonal values
ds = diag(s);
ds = ds.\1;
s(logical(eye(size(s)))) = ds;
%calculate svd solution
sol = v * s' * u' * p2;
disp(sol);
syms x2
f2 = symfun(sol(1) + sol(2)*x2 + sol(3)*x2.^2 + sol(4)*x2.^3,[x2]);
plot(xr2,f2(xr2));
y2 = arrayfun(matlabFunction(f2),xr2);
disp(sum(abs(y2'-p2)));
hold off