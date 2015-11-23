function [] = drawVisibilityGraph(startPoint, endPoint, obsticles, graph)
    clf;
    hold on;
    plot(startPoint(1),startPoint(2),'r.');
    plot(endPoint(1),endPoint(2),'r.');
    
    for k=1:1:length(obsticles)
        cur = obsticles{k};
        line(cur(:,1),cur(:,2));
    end
    
    for j=1:1:size(graph,1)
        line([graph(j,1);graph(j,3)],[graph(j,2);graph(j,4)]);
    end
    
    hold off;
end

