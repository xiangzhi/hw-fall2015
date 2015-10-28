%create the symboilic representation of the function
syms x y;
f = x^3 + y^3 - 2 * x^2 + 3 * y^2 - 8;
%convert it to a matlab function
g = matlabFunction(f);

%create meshgrid of the space
xlin = linspace(-2,4,601);
ylin = linspace(-4,2,601);
[X,Y] = meshgrid(xlin,ylin);
% generate the z matrix;
Z = g(X,Y);
%generate the gradient matrix
[gx, gy] = gradient(Z);
%t = min(min(gy));
%convert the starting point to a point in the space
px = 1; %1
py = -1; %-1

%do the gradient descent
while(true)
    
    
    %find the gradient of the point
    gx = px * (3 * px - 4);
    gy = py * (3 * py + 6);
    
    %check if we reach the end point
    if (gx == 0 && gy == 0)
        disp('finish');
    end
    
    %minimize the function g(t)
    %for now, let just do stupid bisection
    
    t = 1;
    min = 100;
    while(true)
        answer = g(px - t*gx,py - t*gy);
        if answer >= min
            break;
        end
        if answer < min
            min = answer;
            disp(min);
        end
        t = t - 0.0001;
    end
    
    %move the x
    px = px - 1/3 * gx;
    py = py - 1/3 * gy;
    
%     %move inversely to the gradient
%     vx = -1 * gx(2,2);
%     vy = -1 * gy(2,2);
%     
%     %keep moving towards that point untill you find local minimum along the
%     %vector
%     
%     %save the direction
%     yDir = sign(gy);
%     xDir = sign(gx);
%     
%     while(true)
%         px = px + vx;
%         py = py + vy;
%         %check gradient
%         %find the gradient of the point
%         %generate a small meshgrid around the point at 0.1
%         [tx,ty] = meshgrid(linspace(px+0.01,px-0.01,3),linspace(py+0.01,py-0.01,3));
%         tz = g(tx,ty);
%         [gx gy] = gradient(tz);
%         disp(gx);
%         disp(gy);
%         %check if we reach the local min
%         if gx(2,2) == 0 && gy(2,2) == 0
%             break;
%         end
%         
%         vx = -1 * gx(2,2);
%         vy = -1 * gy(2,2);
%         
%         disp(px);
%         disp(py);
%     end
%     %local min reach
%     disp('check');
end





%[gz] = gradient(Z);

%contour(X,Y,gz);

x = 4/3;
y = -2;
oriG = g(x,y);
disp(oriG);
for i = 1:1:3
    for j = 1:1:3
        tx = (x - 0.1) + 0.1*(j-1);
        ty = (y - 0.1) + 0.1*(i-1);
        tg = g(tx,ty);
        disp(fprintf('x:%f y:%f g:%f\n',tx,ty,oriG - tg));
    end
end




%surf(X,Y,Z);
contour(X,Y,Z,200);
%ezsurf(f);
%ezcontour(f,[-10 10],1000);
%plot(f,xlin,ylin);