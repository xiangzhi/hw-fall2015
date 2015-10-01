function [path] = interpolatePath(startingPoint, pathFile)
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
p1 = pathFile{index,1}(1,:);
p1_index = index;
%calculate distance between this point and all other point;
dists2 = pdist2(startPoints,p1);
%concate the startPoints and the distance for a new array\
indexList = (1:49)';
distAndPoint = cat(2,dists2,startPoints,indexList);

distAndPoint = sortrows(distAndPoint);
disp(distAndPoint);
p2 = [0 0];
p2_index = 0;
p3 = [0 0];
p3_index = 0;
%loop through the list
for i = 2:1:49
    curP = distAndPoint(i,:)
    if p1(1,1) > p1(1,2)
        if curP(1,2) > curP(1,3)
            if sum(p2) == 0
                p2 = [curP(1,2),curP(1,3)]
                p2_index = curP(1,4);
            else
                p3 = [curP(1,2),curP(1,3)]
                p3_index = curP(1,4);
                break;
            end
        end
    end
    if p1(1,1) <= p1(1,2)
        if curP(1,2) <= curP(1,3)
            if sum(p2) == 0
                p2 = [curP(1,2),curP(1,3)]
                p2_index = curP(1,4);
            else
                p3 = [curP(1,2),curP(1,3)]
                p3_index = curP(1,4);
                break;
            end
        end            
    end
end

%how we have our 3 points and their index into the path world
disp(p1);
disp(p2);
disp(p3);

%calculate the alpha by solving the Linear Equation of the three triangles
A = [p1(1,1) p2(1,1),p3(1,1);p1(1,2) p2(1,2) p3(1,2);1 1 1];
disp(A);
B = [startingPoint(1,1);startingPoint(1,2);1];
disp(B);
alpha = A\B; %could use SVD here, but matlab could solve this..
disp(alpha);


maxT = 300;
interval = 0.001;
%for now just use the given t for test
path = zeros((1/interval)+1,2);
points = zeros(2,2);
index = 1;
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
    path(index,:) = [(points(1,1)*diff + points(2,1)*(1-diff)) (points(1,2)*diff + points(2,2)*(1-diff))] ;
    index = index + 1;
end
disp(path);

