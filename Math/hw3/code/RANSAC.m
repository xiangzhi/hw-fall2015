function  [bestIndices] = RANSAC(points,comp,tol,itr)
%A simple implementation of RANSAC for our problem

best = -1;
minPoints = 4;

for n=1:1:itr
    %pick the minimum number of points to build the plane
    indices = randperm(size(points,1),minPoints);
    selected = points(indices,:);
    %do the calculations by passing it into the standard function
    [a,b,c,d] = comp(selected);
    %now calculate the distance to all points from the plane
    pointDis = abs(a*points(:,1) + b*points(:,2) + c*points(:,3) + d)/(sqrt(a.^2 + b.^2 + c.^2));
    %only accept points that are less than the tolerance(tol)
    loopPoints = points(pointDis < tol,:);
    if size(loopPoints,1) > best
        best = size(loopPoints,1);
        bestIndices = pointDis < tol;
    end
end

end

