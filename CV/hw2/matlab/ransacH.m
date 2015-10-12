function [bestH,m] = ransacH(matches, locs1, locs2, nIter, tol)
% inspired by the RANSAC algorithm on wikipedia

    %best num, at least 70% inliers
    minAcc = floor(size(matches,1) * 0.70);
    best = -1;
    %intial guess
    initSize = floor(size(matches,1) * 0.05);
    %all the points in the match
    p1 = locs1(matches(:,1),1:2);
    p1 = [p1 ones(size(p1,1),1)];
    p2 = locs2(matches(:,2),1:2);
    p2 = [p2 ones(size(p2,1),1)];
    BestMatches = matches;
    for i=1:1:nIter; 
        
        %get the random % of the matches
        %get the mininum number of points
        indices = randperm(size(matches,1),4);
        rMatch = matches(indices,:);
        
        
        %get the points in the matches
        tmpP1 = locs1(rMatch(:,1),1:2);
        tmpP2 = locs2(rMatch(:,2),1:2);
       
        %generate the h
        tempH = computeH(tmpP1',tmpP2');
        disp(tempH);
        %apply the change to all objects
        newP2 = tempH*p2';
        newP2 = bsxfun(@rdivide, newP2, newP2(3,:));
        newP2 = newP2';
        diff = sum((p1(:,1:2) - newP2(:,1:2)).^2,2);
        diff = sqrt(diff);
        inlierIndex = diff < tol;
        inlier = matches(inlierIndex,:);
        
%         %randomly get a match
%         rMatch = matches(randi(1,size(matches,1),1));
%         %find its d
%         baseD = locs1(rMatch,1:2) - locs2(rMatch,1:2);
%         %disp(baseD);
%         
%         newD = d - baseD;
%         %get an index where the d value is close
%         index = find(abs(newD(:,1)) <=tol & newD(:,2)<=tol);
%         disp(index);
        %disp(size(index));
        disp(size(inlier,1));
        if size(inlier,1) > minAcc && size(inlier,1) > best 
            BestMatches = inlier;
            best = size(inlier,1);
        end
    end
    
    %calculate the h
    m = BestMatches;
    p1 = locs1(BestMatches(:,1),1:2);
    p2 = locs2(BestMatches(:,2),1:2);
    bestH = computeH(p1',p2');
end

