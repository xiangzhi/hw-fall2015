function [] = drawVisibilityGraph(startPoint, endPoint, obsticles, graph, locIndex)
    clf;
    hold on;
    plot(startPoint(1),startPoint(2),'r.');
    plot(endPoint(1),endPoint(2),'r.');
    
    %for k=1:1:length(obsticles)
    %    cur = obsticles{k};
    %    line(cur(:,1),cur(:,2));
    %end
    
    for j=1:1:length(graph)
        connections = graph{j};
        startPt = locIndex(j,:);
        for k=1:1:size(connections,1)
            endPt = locIndex(connections(k),:);
            line([startPt(1);endPt(1)],[startPt(2);endPt(2)]);
        end
    end
    
    hold off;
end

