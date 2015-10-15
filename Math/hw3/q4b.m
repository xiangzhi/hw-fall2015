%q3

id = fopen('data/cluttered_table.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};


hold on

%mesh(points(:,1),points(:,2),points(:,3));

A = ones(size(points,1),4);
A(:,1:3) = points;
[u,s,v] = svd(A'*A);
disp(s);
sol = v(:,end);
disp(sol);

%from stackoverflow
[x y] = meshgrid(-1.5:.2:1.5,0:.1:1);
z = (-1 * sol(1)*x - sol(2)*y - sol(4))/sol(3);
mesh(x,y,z);

%go through all points and calculate the distance to the points
dis = abs(sol(1)*points(:,1) + sol(2)*points(:,2) + sol(3)*points(:,3) + sol(4))/(sqrt(sol(1).^2 + sol(2).^2 + sol(3).^2));
%dis = sqrt((((-1 * sol(1)*points(:,1) - sol(2)*points(:,2) - sol(4))/sol(3)) - points(:,3)).^2);
avgDis = sum(dis)/size(points,1);
scatter3(points(:,1),points(:,2),points(:,3));

hold off;