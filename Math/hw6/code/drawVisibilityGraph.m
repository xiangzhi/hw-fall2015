function [] = drawVisibilityGraph(startPoint, endPoint, obsticles,ori_obsticles,graph, locIndex, bestPath, robotDef)
    clf;
    hold on;
    
    axis('square');
    
    %plot start and ending points
    plot(startPoint(1),startPoint(2),'r.');
    plot(endPoint(1),endPoint(2),'r.');
    
    for j=1:1:length(graph)
        connections = graph{j};
        startPt = locIndex(j,:);
        for k=1:1:size(connections,1)
            endPt = locIndex(connections(k),:);
            line([startPt(1);endPt(1)],[startPt(2);endPt(2)]);
        end
    end
    
    %overdraw the obsticle lines to show them
    for k=1:1:length(obsticles)
        cur = obsticles{k};
        line(cur(:,1),cur(:,2),'Color','r');
    end
    
    %draw the original obsticles 
    for k=1:1:length(ori_obsticles)
        cur = ori_obsticles{k};
        fill(cur(:,1),cur(:,2),'y','FaceAlpha',0.1);
        %line(cur(:,1),cur(:,2),'Color',[.5 0 .5],'LineWidth',1);
    end
    
    %draw the best path lines
    for i=1:1:size(bestPath,2)-1
        curPt = locIndex(bestPath(i),:);
        nxtPt = locIndex(bestPath(i+1),:);
        line([curPt(1);nxtPt(1)],[curPt(2);nxtPt(2)],'Color','g');
    end
    
    %draw the robot at the starting point
    robotDef = robotDef + repmat(startPoint, size(robotDef,1),1);
    fill( robotDef(:,1), robotDef(:,2),'g','FaceAlpha',0.25);
    
    hold off;
end

