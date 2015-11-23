function [ vertices ] = findConvexHull(input)
%find the minimum convex hull based on the graham scan alogirthm
%the basic idea was taken from the wikipedia page.

%first check if there is only one or no points,
%then just return that point.
if(size(input,1) < 1)
    vertices = input;
    return;
end
%first find the smallest point
minPoint = [inf inf];
for i = 1:1:size(input,1)
    if input(i,2) < minPoint(2)
        minPoint = input(i,:);
    elseif input(i,2) == minPoint(2)
        if input(i,1) < minPoint(1)
            minPoint = input(i,:);
        end
    end
end


%interior point
%intPoint = mean(input,1);

%remove the first point
input(find(ismember(input,minPoint),1),:) = [];

%sort the remaining points based on angle to the minimum point
minVec = minPoint;
minVec(1) = (minPoint(1) + 1);
minVec = minVec - minPoint;
drawConvex(input,[],minPoint);
%minVec = intPoint - minPoint;
%used an N^2 algorithm here, but it probablty still fine
for i=1:1:size(input,1)
    %calculate the two angles
    pv = input(i,:) - minPoint;
    %pv = intPoint - input(i,:);
    ia = acos(dot(minVec, pv)/(norm(minVec) * norm(pv)));
    for j=i:1:size(input,1)
        pv = input(j,:) - minPoint;
        %pv = intPoint - input(j,:);
        ja = acos(dot(minVec,pv) /(norm(minVec) * norm(pv)));
        if(ja < ia)
            ia = ja;
            tmp = input(i,:);
            input(i,:) = input(j,:);
            input(j,:) = tmp;
        end
    end
end

%now the input list should be sorted, we start the gradham scan
%add the first point back
input = [minPoint;input];
%find the three points
p1 = input(1,:);
p2 = input(2,:);
p3 = input(3,:);
index = 3;
vertices = p1;

while true
    v1 = p2 - p1;
    v2 = p2 - p3;
    c = cross([v2 0],[v1 0]);
    direction = c(3);
    while direction < 0
        p2 = p1;
        p1 = vertices(end-1,:);
        vertices = vertices(1:end-1,:);
        %p2 = p3;
        %index = rem(index, size(input,1)) + 1;
        %p3 = input(index,:);
        v1 = p2 - p1;
        v2 = p2 - p3;
        c = cross([v2 0],[v1 0]);
        direction = c(3);
        drawConvex(input,vertices,minPoint);
    end
    p1 = p2;
    p2 = p3;
    index = rem(index, size(input,1)) + 1;
    p3 = input(index,:);
    vertices = [vertices;p1];
    if vertices(1,:) == vertices(end,:)
        vertices = vertices(1:end-1,:);
        break;
    end
    drawConvex(input,vertices,minPoint);
end

end

