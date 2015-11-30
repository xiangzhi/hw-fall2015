function [ bestPath ] = dijkstraAlgo(startPoint, endPoint, graph, locIndex)
    
    [~,idx] = ismember(locIndex,startPoint,'rows');
    startIdx = find(idx==1);
    [~,idx] = ismember(locIndex,endPoint,'rows');
    endIdx = find(idx==1);
    
    costList = ones(size(locIndex,1),1);
    visitedList = zeros(size(locIndex,1),1);
    costList = costList .* Inf;
    prevList = ones(size(locIndex,1),1);
    
    
    %initialize the point
    curIdx = startIdx;
    costList(curIdx) = 0;
    visitedList(curIdx) = 1;
    
    %do the loop
    while true
        %check if the current index is the endIdx
        if curIdx == endIdx
            break;
        end
    
        %calculate the cost to all the neighbors.
        connectedList = graph{curIdx};
        curPt = locIndex(curIdx,:);
        for i=1:1:size(connectedList,1)
            %we only calculate it for unvisited nodes
            if visitedList(connectedList(i)) ~= 0
                continue;
            end
            nextPt = locIndex(connectedList(i),:);
            %calculate the cost from the current point to the next point
            cost = pdist([curPt; nextPt]);
            %add the previous cost
            cost = cost + costList(curIdx);
            %update the cost if it's smaller
            if cost < costList(connectedList(i))
                costList(connectedList(i)) = cost;
                prevList(connectedList(i)) = curIdx;
            end
        end
        
        %mark the current node as visited
        visitedList(curIdx) = 1;
        %sanity check to make sure all connecting nodes are valid
        if sum(costList(visitedList == 0) ~= Inf) == 0
            %none of the remaining nodes are connecting,
            %this should NOT happen
            disp('ERROR');
        end
        
        %find the unvisitednode with the smallest cost and set as current]
        t = costList(visitedList == 0);
        minVal = min(costList(visitedList == 0));
        curIdx = find(costList == minVal);
        while size(curIdx,1) > 1
            if visitedList(curIdx(end)) == 0
                curIdx = curIdx(end);
                break;
            else
                curIdx = curIdx(1:end-1);
            end
        end
    end
    
    %now will just reverse traversal the list to find the best path
    bestPath = [curIdx];
    while curIdx ~= startIdx
        curIdx = prevList(curIdx);
        bestPath = [curIdx bestPath];
    end
end


%[graph,locIndex] = createVisibilityGraph(startPoint, endPoint, obsticles);

