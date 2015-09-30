function [result] = dividedDifferences(n,x,xs,fxs)
%Divided Differences

%first build the divided difference table
table = buildTable(n,xs,fxs);

%pass into the recursive method
result = dividedDifferencesRecursive(n,x,xs,fxs, table);

end