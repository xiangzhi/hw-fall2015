
%get the input files and arrange data in a nice way
id = fopen('data/clean_hallway.txt');
data = textscan(id,'%f %f %f');
points = ones(size(data{1,1},1),3);
points(:,1) = data{1,1};
points(:,2) = data{1,2};
points(:,3) = data{1,3};

% run ransac on the data
hold on
list = RANSAC_improved(points,@planeSolver,0.005,1000);
for i=1:size(list,1)
    fits = list{i};
    [a,b,c,d] = planeSolver(fits);
    
    %find tha max and min of each fits 
    xMax = max(fits(:,1));
    xMin = min(fits(:,1));
    yMax = max(fits(:,2));
    yMin = min(fits(:,2));
    
    [x y] = meshgrid(xMin:(xMax/xMin)/100:xMax,yMin:(yMax/yMin)/100:yMax);
    z = (-1 * a*x - b*y - d)/c;
    mesh(x,y,z);
end

%draw the points
scatter3(points(:,1),points(:,2),points(:,3));