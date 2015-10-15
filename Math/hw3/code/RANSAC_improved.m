function  [list] = RANSAC_improved(points,comp,tol,itr)
%An upgraded version of our RANSAC

list = cell(4,1);

for i=1:4
    indices = RANSAC(points,comp,tol,itr);
    list{i} = points(indices,:);
    %remove the points from the list
    points = points(~indices,:);
    %rerun the algorthim
end
end
