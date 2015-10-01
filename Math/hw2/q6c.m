%part c of the question

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
    roots(1) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
    x0 = 5;
    x1 = 6;
    x2 = 7;
    roots(2) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
    x0 = 9;
    x1 = 10;
    x2 = 11;
    roots(3) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
    x0 = 12;
    x1 = 13;
    x2 = 14;
    roots(4) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
    if roots == oldroots
        break;
    end
    oldroots = roots;
end
disp(k);
disp(roots);