function [ vertices] = buildObjectBorder(points)
    points = unique(points,'rows');
    shape =  findConvexHull(points);
    shape = [shape; shape(1,:)];
    cleanList = [shape(1,:)];
    
    %remove any points that are colinear.
    for j=2:1:size(shape,1)-1
        s1 = (shape(j,2) - shape(j-1,2))/(shape(j,1) - shape(j-1,1));
        s2 = (shape(j+1,2) - shape(j,2))/(shape(j+1,1) - shape(j,1));
        if s2 ~= s1
            cleanList = [cleanList; shape(j,:)];
        end
    end
    vertices = [cleanList;shape(end,:)];
end

