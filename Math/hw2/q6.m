

%;
% 
% fx2 = @(x)(x - tan(x));
% ezplot(fx2,[-10,10]);
% disp(bisectionMethod(-4.5,-3.5,fx2,0.001))
% fx3 = @(x)(x^3 - 3*x + 2);
% 
% x0 = -4.35;
% x1 = -4.0;
% x2 = -3.8;
% limit = 0.001;
% maxLoop = 1000;
% a = mullerMethod(x0,x1,x2,limit,maxLoop,fx2);
% disp(a);
% disp(real(a));

%syms x;
%eq1 = besselFunction(x);
%ezplot(eq1);

limit = 0.001;
maxLoop = 1000;
oldroots = zeros(4,1);
roots = zeros(4,1);
k= 3;
for k = 3:1:100
    fx = @(x)(besselFunction(x,k));
    x0 = 3;
    x1 = 4;
    x2 = 5;
    roots(1) = mullerMethod(x0,x1,x2,limit,maxLoop,fx);
    x0 = 5;
    x1 = 6;
    x2 = 7;
    roots(2) = mullerMethod(x0,x1,x2,limit,maxLoop,fx);
    x0 = 9;
    x1 = 10;
    x2 = 11;
    roots(3) = mullerMethod(x0,x1,x2,limit,maxLoop,fx);
    x0 = 12;
    x1 = 13;
    x2 = 14;
    roots(4) = mullerMethod(x0,x1,x2,limit,maxLoop,fx);
    if roots == oldroots
        break;
    end
    oldroots = roots;
end
disp(k);
disp(roots);

