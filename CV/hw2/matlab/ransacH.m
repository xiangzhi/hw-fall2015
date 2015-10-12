function [bestH,m] = ransacH(matches, locs1, locs2, nIter, tol)
% inspired by the RANSAC algorithm on wikipedia

    %best num, at least 60% inliers
    best = floor(size(matches,1) * 0.60);
   
    
    %calculate the distance between points
    p1 = locs1(matches(:,1),1:2);
    p2 = locs2(matches(:,2),1:2);
    d = p1 - p2;
    %disp(d);
    for i=1:1:nIter; 
        %randomly get a match
        rMatch = matches(randi(1,size(matches,1),1));
        %find its d
        baseD = locs1(rMatch,1:2) - locs2(rMatch,1:2);
        %disp(baseD);
        
        newD = d - baseD;
        %get an index where the d value is close
        index = find(abs(newD(:,1)) <=tol & newD(:,2)<=tol);
        disp(index);
        %disp(size(index));
        if size(index,1) > best
            matches = matches(index,:);
            break;
        end
    end
    
    %calculate the h
    m = matches;
    p1 = locs1(matches(:,1),1:2);
    p2 = locs2(matches(:,2),1:2);
    bestH = computeH(p1',p2');
end

