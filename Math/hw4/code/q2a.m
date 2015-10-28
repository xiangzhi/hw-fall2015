syms x y;
f = x^3 + y^3 - 2 * x^2 + 3 * y^2 - 8;
g = matlabFunction(f);
xlin = linspace(4,-2,600);
ylin = linspace(2,-4,600);

[X,Y] = meshgrid(xlin,ylin);
Z = g(X,Y);
%[gz] = gradient(Z);

%contour(X,Y,gz);

x = 4/3;
y = 0;
oriG = g(x,y);
disp(oriG);
for i = 1:1:3
    for j = 1:1:3
        px = (x - 0.1) + 0.1*(j-1);
        py = (y - 0.1) + 0.1*(i-1);
        gx = px * (3 * px - 4);
        gy = py * (3 * py + 6);
        fprintf('x:%f y:%f gx:%f gy:%f\n',px,py,gx,gy);
    end
end




%surf(X,Y,Z);
contour(X,Y,Z,200);
%ezsurf(f);
%ezcontour(f,[-10 10],1000);
%plot(f,xlin,ylin);