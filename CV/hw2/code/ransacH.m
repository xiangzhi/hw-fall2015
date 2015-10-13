function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
%find the best h by randomly select points and picking the picks with the
%most inliers defined by the translation of points that lies within tol.
% inspired by the RANSAC algorithm on wikipedia

    best = -1;
    %all the points in the match
    p1 = locs1(matches(:,1),1:2);
    p1 = [p1 ones(size(p1,1),1)];
    p2 = locs2(matches(:,2),1:2);
    p2 = [p2 ones(size(p2,1),1)];
    BestMatches = matches;
    for i=1:1:nIter; 
        
        %get the mininum number of points
        indices = randperm(size(matches,1),4);
        rMatch = matches(indices,:);
        
        %get the points in the matches
        tmpP1 = locs1(rMatch(:,1),1:2);
        tmpP2 = locs2(rMatch(:,2),1:2);
       
        %generate the h
        tempH = computeH(tmpP1',tmpP2');
        %apply the change to all objects
        newP2 = tempH*p2';
        newP2 = bsxfun(@rdivide, newP2, newP2(3,:));
        newP2 = newP2';
        diff = sum((p1(:,1:2) - newP2(:,1:2)).^2,2);
        diff = sqrt(diff);
        inlierIndex = diff < tol;
        inlier = matches(inlierIndex,:);
        
        if size(inlier,1) > best 
            BestMatches = inlier;
            best = size(inlier,1);
        end
    end
    
    %calculate the h
    p1 = locs1(BestMatches(:,1),1:2);
    p2 = locs2(BestMatches(:,2),1:2);
    bestH = computeH(p1',p2');
end

