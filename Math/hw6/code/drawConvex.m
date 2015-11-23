function [] = drawConvex(points, hull, midpoint)
    clf;
    hold on;
    %draw all the points
    scatter(points(:,1), points(:,2),15,[0,0,1],'filled');
    
    if size(hull,2) == 2
        line(hull(:,1),hull(:,2),'Color',[1 0 0]);
    end
    
    for j=1:1:size(points)
        line([midpoint(1);points(j,1)],[midpoint(2);points(j,2)]);
    end
    
    hold off;
end

