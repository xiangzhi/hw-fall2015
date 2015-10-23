function [path, interPath] = interpolatePath(startingPoint, pathFile)
%given the starting point and the paths in a 49x1 cell
%return a path based on the interval


%most stupid algorithm
%just find the closest region
dists = zeros(length(pathFile),0);
startPoints = zeros(49,2);
for i=1:1:length(pathFile)
    start = pathFile{i,1}(1,:);
    startPoints(i,:) = pathFile{i,1}(1,:);
    dists(i,1) = pdist2(startingPoint,start);
end

%find the smallest point
[small index] = min(dists);
point1 = pathFile{index,1}(1,:);
p1_index = index;

%loop through all the points to find two other points with the 
%following condition
%1. the smallest triangle that emcompose the point
%2. has to pointing in the same direction
minArea = 10000;
p2_index = 0;
p3_index = 0;
p1Sign = point1(1) - point1(2);
for i=1:1:size(startPoints,1)
    if i == p1_index
        continue;
    end
    point2 = startPoints(i,:);
    p2Sign = point2(1) - point2(2);
    for j=1:1:size(startPoints,1)
        %ignore if it's itself or the starting point
        if j == i || j == p1_index
            continue;
        end
        point3 = startPoints(j,:);
        p3Sign = point3(1) - point3(2);
        %check directions
        if (p1Sign <= 0 & p2Sign <= 0 & p3Sign <= 0) || (p1Sign > 0 & p2Sign > 0 & p3Sign > 0)
            %check if the point is in the 3 points
            alpha = calBarycentric(startingPoint,point1,point2,point3);
            if sum(alpha) == 1 & alpha(1) >= 0 & alpha(2) >= 0 & alpha(3) >= 0
                %calculate the area of the triangle
                area = polyarea([point1(1),point2(1),point3(1)],[point1(2),point2(2),point3(2)]);
                if area < minArea
                    minArea = area;
                    p2_index = i;
                    p3_index = j;
                end
            end
        end
    end
end

%get the alpha of the barycentric
alpha = calBarycentric(startingPoint,startPoints(p1_index,:),startPoints(p2_index,:), startPoints(p3_index,:));
check = sum(alpha);
interval = 0.01;
%for now just use the given t for test
path = zeros((1/interval)+1,2);
points = zeros(2,2);
index = 1;
interPath = [p1_index p2_index p3_index ];
for t=0:interval:1
    
    x = alpha(1,1) * pathFile{p1_index,1}(ceil(t * 49) + 1,1) + alpha(2,1) * pathFile{p2_index,1}(ceil(t * 49) + 1,1) + alpha(3,1) * pathFile{p3_index,1}(ceil(t * 49) + 1,1);
    y = alpha(1,1) * pathFile{p1_index,1}(ceil(t * 49) + 1,2) + alpha(2,1) * pathFile{p2_index,1}(ceil(t * 49) + 1,2) + alpha(3,1) * pathFile{p3_index,1}(ceil(t * 49) + 1,2);
    points(1,:) = [x y];
    x = alpha(1,1) * pathFile{p1_index,1}(floor(t * 49) + 1,1) + alpha(2,1) * pathFile{p2_index,1}(floor(t * 49) + 1,1) + alpha(3,1) * pathFile{p3_index,1}(floor(t * 49) + 1,1);
    y = alpha(1,1) * pathFile{p1_index,1}(floor(t * 49) + 1,2) + alpha(2,1) * pathFile{p2_index,1}(floor(t * 49) + 1,2) + alpha(3,1) * pathFile{p3_index,1}(floor(t * 49) + 1,2);
    points(2,:) = [x y];
    
    
    %get the decimal part
    integ=floor(t);
    diff=t-integ;
    path(index,:) = [(points(1,1)*(1 - diff) + points(2,1)*diff) (points(1,2)*(1-diff) + points(2,2)*diff)] ;
    index = index + 1;
end

