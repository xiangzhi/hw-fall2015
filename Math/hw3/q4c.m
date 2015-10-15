
%get the input files and arrange data in a nice way
id = fopen('data/cluttered_table.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};

%run ransac on the data
%0.005 because that was the average distance back in Q4(a)
bestPoints = points(RANSAC(points,@planeSolver,0.005,1000),:);

%now we solve the plane
[a,b,c,d] = planeSolver(bestPoints);

%draw the plane
hold on
[x y] = meshgrid(-1.5:.2:1.5,0:.1:1);
z = (-1 * a*x - b*y - d)/c;
mesh(x,y,z);

%draw the points
scatter3(points(:,1),points(:,2),points(:,3));
hold off