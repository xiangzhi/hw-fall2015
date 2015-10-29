%question 1c

y = -1;
n = 0;
h = -0.05 %step size

%the given function
eq = @(x,y) 2/(x.^2 * (1 - y));
eq2 = @(x) 1 - 2 * sqrt(1/x);

%Ruuge-Kutter
for i=1:-0.05:0
   %find k1
   k1 = h * eq(i,y);
   %find k2
   k2 = h * eq(i + h/2,y + k1/2);
   %find k3
   k3 = h * eq(i + h/2, y + k2/2);
   %find k4
   k4 = h * eq(i + h, y + k3);
   %find the final newy
   newY = y + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
   fprintf('%d & %f & %f & %f \\\\ \\hline \n',n,i,y,eq2(i));
   y = newY;
   n = n + 1;
end