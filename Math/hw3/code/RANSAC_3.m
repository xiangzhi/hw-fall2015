function  [list] = RANSAC_3(points,comp,tol,itr)
%An upgraded version of our RANSAC

list = cell(4,1);
maxDis = 0.5;

for i=1:4
    
    best = -1;
    minPoints = 4;
    bestIndices = [];
    
    for n=1:1:itr
        %randomly pick one point
        point = points(randi([1,size(points,1)]),:);
        %find minPoint-1 points that close to it, but not itself
        closePoints = points(pdist2(point,points) < maxDis & pdist2(point,points) > 0,:);
        if size(closePoints,1) < minPoints-1
            continue
        end
        selected = [closePoints(randperm(size(closePoints,1),minPoints-1),:); point];
        
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
    
    list{i} = points(bestIndices,:);
    %remove the points from the list
    points = points(~bestIndices,:);
    %rerun the algorthim
end

end
