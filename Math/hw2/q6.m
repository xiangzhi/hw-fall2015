

%;
% 
fx2 = @(x)(x - tan(x));
ezplot(fx2,[10,15]);
disp(bisectionMethod(0,2,fx2,0.001))
fx3 = @(x)(x^3 - 3*x + 2);

x0 = 10;
x1 = 10.5;
x2 = 10.95;
limit = 0.001;
maxLoop = 100;
a = mullerMethod2(x0,x1,x2,limit,maxLoop,fx2);
disp(a);
disp(real(a));

%syms x;
%eq1 = besselFunction(x);
%ezplot(eq1);


%part c of the question

% limit = 0.001;
% maxLoop = 1000;
% oldroots = zeros(4,1);
% roots = zeros(4,1);
% k= 3;
% for k = 3:1:100
%     fx = @(x)(besselFunction(x,k));
%     x0 = 3;
%     x1 = 4;
%     x2 = 5;
%     roots(1) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
%     x0 = 5;
%     x1 = 6;
%     x2 = 7;
%     roots(2) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
%     x0 = 9;
%     x1 = 10;
%     x2 = 11;
%     roots(3) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
%     x0 = 12;
%     x1 = 13;
%     x2 = 14;
%     roots(4) = mullerMethod2(x0,x1,x2,limit,maxLoop,fx);
%     if roots == oldroots
%         break;
%     end
%     oldroots = roots;
% end
% disp(k);
% disp(roots);

