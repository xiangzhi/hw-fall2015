function [graph] = createVisibilityGraph(startPoint, endPoint, obsticles)


obsticleEdges = []; %the edges of obsticles
startEdges = []; % edges from start point to the vertices of each obsticle
endEdges = [];%edges from end point to all vertices

%first generate all the obsticles edges
%also generate all edges from start/end point to each vertices
for k=1:length(obsticles)
    obsticle = obsticles{k};
    for i=1 : 1 :(size(obsticle,1)-1)
        
        startEdge = [startPoint obsticle(i,:)];
        startEdges = [startEdges; startEdge];
        
        endEdge = [obsticle(i,:) endPoint];
        endEdges = [endEdges; endEdge]
        
        edge = [obsticle(i,:) obsticle(i+1,:)];
        obsticleEdges = [obsticleEdges;edge];
    end
end

%there's also a edge between start and end
edge = [startPoint endPoint];
startEdges = [startEdges; edge];


%now we test every single startEdge to see if they overlap or not with 
%an obsticle edge
se = [];
for i = 1:1:size(startEdges,1)
    %now we do the tests
    fail = false;
    startE = startEdges(i,:);
    for j=1:1:size(obsticleEdges,1)
        obE = obsticleEdges(j,:);
        
        %check if they share the same starting and ending points, if they
        %do, it's probably okay
        if obE(1:2) == startE(3:4) | obE(3:4) == startE(1:2) | ...
                obE(1:2) == startE(1:2) | obE(3:4) == startE(3:4)
            continue;
        end
        
        
        p1Check = (startE(1) - startE(3))*(obE(1) - startE(2)) - (startE(2) - startE(4))*(obE(2) - startE(1));
        p2Check = (startE(1) - startE(3))*(obE(3) - startE(2)) - (startE(2) - startE(4))*(obE(4) - startE(1));
        
        if sign(p1Check) == sign(p2Check)
            continue;
        end
        
        fail = true;
        break;
    end
    
    if ~fail
        se = [se;startEdges(i,:)];
    end
    
end 

graph = [se; endEdges; obsticleEdges];
%generate vertices from the starting point to all the vertices
