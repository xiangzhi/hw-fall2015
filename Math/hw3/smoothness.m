function [score] = smoothness(points,a,b,c,d)
%A function that returns the score of the smoothness function
    %go through all points and calculate the distance to the points
    dis = abs(a*points(:,1) + b*points(:,2) + c*points(:,3) + d)/(sqrt(a.^2 + b.^2 + c.^2));
    %dis = sqrt((((-1 * sol(1)*points(:,1) - sol(2)*points(:,2) - sol(4))/sol(3)) - points(:,3)).^2);
    score = sum(dis)/size(points,1);
end

