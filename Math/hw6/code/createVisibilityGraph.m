function [graph, locIndex] = createVisibilityGraph(startPoint, endPoint, obsticles)


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
        endEdges = [endEdges; endEdge];
        
        edge = [obsticle(i,:) obsticle(i+1,:)];
        obsticleEdges = [obsticleEdges;edge];
    end
end

%now we generate a list for all edges on each obsticle to each
obE


%there's also a edge between start and end
edge = [startPoint endPoint];
startEdges = [startEdges; edge];


%now we test every single startEdge to see if they overlap or not with 
%an obsticle edge
se = edgeIntersectionCheck(startEdges, obsticleEdges);
ee = edgeIntersectionCheck(endEdges, obsticleEdges);

edges = [se; ee; obsticleEdges];

%generate a matrix that shows the link between vertices
graphSize = max([prod(size(se)) prod(size(ee)) prod(size(obsticleEdges))]);

locIndex = zeros(graphSize,2);
locIndexPtr = 2;
graph = cell(1,graphSize);
%initialize each cell as empty matrices?
stack = [startPoint];
locIndex(1,:) = startPoint;
%search through all the edges and see which edge is connected to one,
%if connected then add to graph
while size(stack,1) ~= 0
    
    %see which vertices we are search for
    curSearch = stack(end,:);
    if size(stack,1) > 2
        stack = stack(1:end-1,:)
    else
        stack = [];
    end
    
    %find the index of the currentPoint
     [~,curIdx] = ismember(locIndex,curSearch,'rows');
     curIdx = find(curIdx==1);
    
    %look through all the edges that start at the current Point
    %add the points to it
    for j=1:1:size(edges,1)
        if(edges(j,1:2) == curSearch)
            
            endPt = edges(j,3:4);
            %first check if we already have indexed the end point
            if(~ismember(locIndex,endPt,'rows'))
                %give it an index
                locIndex(locIndexPtr,:) = endPt;
                locIndexPtr = locIndexPtr + 1;
                %push it onto stack
                stack = [endPt;stack];
            end
            %find the locIndex for the end point
            [~,idx] = ismember(locIndex,endPt,'rows');
            idx = find(idx==1);
            %add it to the search graph for this startpoint
            graph{curIdx} = [graph{curIdx};idx];
        end
        
        %repeat the search in the oposite direction
        if(edges(j,3:4) == curSearch)
            
            endPt = edges(j,1:2);
            %first check if we already have indexed the end point
            if(~ismember(locIndex,endPt,'rows'))
                %give it an index
                locIndex(locIndexPtr,:) = endPt;
                locIndexPtr = locIndexPtr + 1;
                %push it onto stack
                stack = [endPt;stack];
            end
            %find the locIndex for the end point
            [~,idx] = ismember(locIndex,endPt,'rows');
            idx = find(idx==1);
            %add it to the search graph for this startpoint
            graph{curIdx} = [graph{curIdx};idx];
        end
        
    end
end
end