syms x
syms y
Q = [2 0 2*x.^2-1 0;0 2 0 2*x.^2-1;1 2*x-1 x^2+x 0;0 1 2*x-1 x^2+x];
disp(Q);
a = (det(Q));
disp(a);

b = [16 -16 0 12 -1]';

c = roots(b);
disp(c);

eq1 = 2*x.^2 + 2*y.^2 - 1;
ezplot(eq1,[-1,1]);
hold on
eq2 = x.^2 + y.^2 + 2*x*y + x -y;
ezplot(eq2,[-1,1]);

plot(-0.7021,-0.0840,'*');
plot(0.0841,0.7020,'*');

%ezplot(eq1,eq2,[-2,2])syms x y
g =  -0.7021
disp(sqrt((1 - 2 * g.^2)/2));
