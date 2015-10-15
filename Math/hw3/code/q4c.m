
%get the input files and arrange data in a nice way
id = fopen('data/cluttered_table.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};

%run ransac on the data
%0.005 because that was the average distance back in Q4(a)
fits = points(RANSAC(points,@planeSolver,0.005,1000),:);

%now we solve the plane
[a,b,c,d] = planeSolver(fits);

%draw the plane
hold on
%find tha max and min of each fits 
xMax = max(fits(:,1));
xMin = min(fits(:,1));
yMax = max(fits(:,2));
yMin = min(fits(:,2));

[x y] = meshgrid(xMin:(xMax-xMin)/100:xMax,yMin:(yMax-yMin)/100:yMax);
z = (-1 * a*x - b*y - d)/c;
mesh(x,y,z);

%go through all points and calculate the distance to the points
dis = abs(a*fits(:,1) + b*fits(:,2) + c*fits(:,3) + d)/(sqrt(a.^2 + b.^2 + c.^2));
%dis = sqrt((((-1 * sol(1)*points(:,1) - sol(2)*points(:,2) - sol(4))/sol(3)) - points(:,3)).^2);
avgDis = sum(dis)/size(fits,1);

%draw the points
scatter3(points(:,1),points(:,2),points(:,3));
hold off