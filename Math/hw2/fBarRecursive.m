function [result] = fBarRecursive(n,xs,fxs,start,endRange)
%to find the f[] values

%base case
%where there are only one element
if start == endRange
    result = fxs(start);
    return;
end

%normal case
up = fBarRecursive(n,xs,fxs,start,endRange-1) - fBarRecursive(n,xs,fxs,start+1,endRange);
down = xs(start) - xs(endRange);
result = up/down;
%disp('f');
%disp(result)
end