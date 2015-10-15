%q4a.m

id = fopen('data/clear_table.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};


hold on

%mesh(points(:,1),points(:,2),points(:,3));

[a,b,c,d] = planeSolver(points);


%find tha max and min of each fits 
xMax = max(points(:,1));
xMin = min(points(:,1));
yMax = max(points(:,2));
yMin = min(points(:,2));

[x y] = meshgrid(xMin:(xMax-xMin)/100:xMax,yMin:(yMax-yMin)/100:yMax);
z = (-1 * a*x - b*y - d)/c;
mesh(x,y,z);

%go through all points and calculate the distance to the points
dis = abs(a*points(:,1) + b*points(:,2) + c*points(:,3) + d)/(sqrt(a.^2 + b.^2 + c.^2));
%dis = sqrt((((-1 * sol(1)*points(:,1) - sol(2)*points(:,2) - sol(4))/sol(3)) - points(:,3)).^2);
avgDis = sum(dis)/size(points,1);
scatter3(points(:,1),points(:,2),points(:,3));

hold off;