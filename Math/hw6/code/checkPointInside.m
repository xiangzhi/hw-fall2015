function [bool] = checkPointInside(pts, pt)
%Check if the point is inside
    cp = [pts;pt];
    pp = findConvexHull(cp);
    [~,curIdx] = ismember(pp,pt,'rows');
    if sum(curIdx) > 0
        bool = false;
    else
        bool = true;
    end
end

