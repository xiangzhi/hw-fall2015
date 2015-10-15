
%get the input files and arrange data in a nice way
id = fopen('data/cluttered_hallway.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};

xMax = max(points(:,1));
xMin = min(points(:,1));
yMax = max(points(:,2));
yMin = min(points(:,2));

% run ransac on the data
hold on
list = RANSAC_3(points,@planeSolver,0.05,1000);
best = 100000;
index = -1;
for i=1:size(list,1)
    fits = list{i};
    [a,b,c,d] = planeSolver(fits);
    
    %find tha max and min of each fits 
    xMax = max(fits(:,1));
    xMin = min(fits(:,1));
    yMax = max(fits(:,2));
    yMin = min(fits(:,2));
    [x y] = meshgrid(xMin:(xMax - xMin)/100:xMax,yMin:(yMax- yMin)/100:yMax);
    z = (-1 * a*x - b*y - d)/c;
    %mesh(x,y,z,'FaceAlpha','0.25');
    scatter3(fits(:,1),fits(:,2),fits(:,3),'MarkerFaceColor','green');
    if smoothness(points,a,b,c,d) < best
        best = smoothness(points,a,b,c,d)
        index  = i;
    end
end



%redraw the best scale
disp(best);
fits = list{index};
[a,b,c,d] = planeSolver(fits);

%find tha max and min of each fits 
xMax = max(fits(:,1));
xMin = min(fits(:,1));
yMax = max(fits(:,2));
yMin = min(fits(:,2));
[x y] = meshgrid(xMin:(xMax - xMin)/100:xMax,yMin:(yMax- yMin)/100:yMax);
z = (-1 * a*x - b*y - d)/c;
mesh(x,y,z,'FaceAlpha','0.25');
scatter3(fits(:,1),fits(:,2),fits(:,3),'MarkerFaceColor','blue');

%draw the points
%scatter3(points(:,1),points(:,2),points(:,3));
hold off