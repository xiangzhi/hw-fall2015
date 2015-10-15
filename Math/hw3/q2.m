%question 2
id = fopen('data/problem2.txt');
data = textscan(id,'%f');
data = data{1,1};
x = linspace(0,100,101);
x = x./10;
x = x';

plot(x,data);

phi1 = ones(size(data,1),1);
phi2 = x;
phi3 = x.^2;
phi4 = x.^3;
combineMat = [phi1 phi2 phi3 phi4];
[u s v] = svd(combineMat);
%flip the diagonal values
ds = diag(s);
ds = ds.\1;
s(logical(eye(size(s)))) = ds;
disp(s);
%calculate svd solution
sol = v * s' * u' * data;
disp(sol);

%syms x1
%f = symfun(-4.1479 + 18.1214*x1 - 4.1499 * x1.^2 + 0.3222 * x1.^3, [x1])