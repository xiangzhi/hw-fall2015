%question 1(b) - plot f(x) = sinh(x);
x = linspace(-2,2,100);
y = sinh(x);


hold on
plot(x,y);


disp(cosh(2)-cosh(-1));

%1c
%syms b
% solve(sinh(acosh(b)) - b * (acosh(b)) == 2*b - sinh(2),b)
% b = 1.60023



%1d
%fp1 = 2 * cosh(2) + 2 * cosh(-2) - sinh(2) + sinh(-2)
%fp2 = (4-1/3)*cosh(2) - (4-1/3)*cosh(-2) - 2 * (2 * sinh(2) + 2 * sinh(-2) - (cosh(2) - cosh(-2)))

syms x1;
f = symfun(1.60023 *x1, [x1]);
plot(x,f(x));

% syms x1;
% f = symfun(1.6 *x1, [x1]);
% plot(x,f(y));
%hold off