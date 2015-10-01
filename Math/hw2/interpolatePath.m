function [path] = interpolatePath(startingPoint, pathFile)


startPoints = zeros(49,2);
for i=1:1:length(pathFile)
    startPoints(i,:) = pathFile{i,1}(1,:);
end


%most stupid algorithm
%just find the closest region
dists = zeros(length(pathFile),0);
for i=1:1:length(pathFile)
    start = pathFile{i,1}(1,:);
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
%for now just use the given t for test
path = zeros(maxT,2);
for t=1:1:maxT
    x = alpha(1,1) * pathFile{p1_index,1}(ceil(t * 50/maxT),1) + alpha(2,1) * pathFile{p2_index,1}(ceil(t * 50/maxT),1) + alpha(3,1) * pathFile{p3_index,1}(ceil(t * 50/maxT),1);
    y = alpha(1,1) * pathFile{p1_index,1}(ceil(t * 50/maxT),2) + alpha(2,1) * pathFile{p2_index,1}(ceil(t * 50/maxT),2) + alpha(3,1) * pathFile{p3_index,1}(ceil(t * 50/maxT),2);
    path(t,:) = [x y];
end
disp(path);

% disp(p1);
% %the idea is find only points towards one direction, either the negative or
% %the positive
% startPoints = startPoints - startPoints(index);
% disp(startPoints);

