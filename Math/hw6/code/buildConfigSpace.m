function [obsticles] = buildConfigSpace(bodyDef, obsticles)

%create vector def
bodyVec = ones(size(bodyDef,1)-1,2);
for i=1:1:size(bodyDef,1)-1
    bodyVec(i,:) = bodyDef(i+1,:) - bodyDef(i,:);
    %invert the vectors
    bodyVec(i,:) = bodyVec(i,:) .* -1;
end

%build the configuration space
for i=1:1:length(obsticles)
    curOb = obsticles{i};
    
    %calculate the points if we apply the body definition on it.
    collect = [];
    for j = 1:1:size(curOb,1)
        pts = repmat(curOb(j,:),size(bodyDef,1),1) - bodyDef; 
        collect = [collect; pts];
    end
    collect = unique(collect,'rows');
    disp(collect);
    shape =  findConvexHull(collect);

%     %first find the mimumum and move the thing to (0,0)
%     minDis = -inf;
%     idx = 0;
%     for j=1:1:size(curOb,1)
%         if sqrt(sum(curOb(j,:).^ 2)) > minDis
%             idx = j;
%             minDis = sqrt(sum(curOb(j,:).^ 2));
%         end
%     end
%     
%     trans = curOb(idx,:);
%     curOb = curOb - repmat(trans,size(curOb,1),1);
%     
%     %create the vector def for it
%     obVec = ones(size(curOb,1)-1,2);
%     for j=1:1:size(curOb,1)-1
%         obVec(j,:) = curOb(j+1,:) - curOb(j,:);
%     end
%     
%     
%     %find the
%     
%     %find the translation of the minimum point
%     %minTrans = 
%     
%     
%     %save the basis location so we can go back
%     baseLoc = curOb(1,:);
%     baseVec = curOb(2,:) - curOb(1,:);
%     
%     %create a combine loop
%     combList = [bodyVec; obVec];
%     
%     %create a list of angle 
%     angleList = ones(size(combList,1),1);
%     
%     baseAngle = atan2(baseVec(2),baseVec(1));
%     if baseAngle < 0
%         baseAngle = (pi * 2) + baseAngle;
%     end
%     
%     
%     for j=1:1:size(combList,1)
%         c = combList(j,:);
%         %angleList(j) = dot(baseVec,c)/(norm(baseVec) * norm(c));
%         t = atan2(c(2),c(1));
%         t = t - baseAngle;
%         if t < 0
%             t = (pi * 2) + t;
%         end
%         angleList(j) = t;
%     end
%     [~,idx] = sort(angleList);
%     
%     %now join all them together.
%     vecX = [];
%     for j=1:1:size(idx,1)
%         vecX = [vecX; combList(idx(j),:)];
%     end
%     
%     disp(vecX);
%     
%     %visualize the vectors
%     hold on
%     %axis([-5,5,-5,5]);
%     curPt = [0 0];
%     for j=1:1:size(vecX,1)
%         nxtPt = curPt + vecX(j,:);
%         line([curPt(1);nxtPt(1)],[curPt(2);nxtPt(2)],'Color','b');
%         curPt = nxtPt;
%     end
%     hold off
%     
%     
%     %merge the vectors and translate them back to their original form of
%     %points
%     %find the index of the original point
%     obNewList = ones(size(vecX,1) + 1,2);
%     obNewList(1,:) = [0 0];
%     for j=1:1:size(vecX,1)
%         obNewList(j+1,:) = obNewList(j,:) + vecX(j,:);
%     end
%     %obNewList(end,:) = baseLoc;
%     obNewList = obNewList + repmat(trans,size(obNewList,1),1);
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
    t = [cleanList;shape(end,:)];
    obsticles{i} = [cleanList;shape(end,:)];
    
%     
%     obNewList(1,:) = baseLoc;
%     obNewList(2,:) = obNewList(1,:) + baseVec;
%     idx = 3;
%     [~,curIdx] = ismember(vecX,baseVec,'rows');
%     curIdx = find(curIdx==1);
%     curIdx = curIdx(1);
%     endIdx = curIdx;
%     %now loop through the whole things once
%     while true
%         nxtIdx = rem(curIdx,size(vecX,1)) + 1;
%         if nxtIdx == endIdx
%             break
%         end
%         obNewList(idx,:) = obNewList(idx-1,:) + vecX(nxtIdx,:);
%         idx = idx + 1;
%         curIdx = nxtIdx;
%     end
end

