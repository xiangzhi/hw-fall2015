function [result] = dividedDifferencesRecursive(n,x,xs,fxs, table)

    %base case
    if n == 0
        result = fxs(n+1);
        return;
    end

    %normal case
    %find lead coefficient function.
    result = dividedDifferencesRecursive(n-1,x,xs,fxs,table);
    %look up the value in the tabl
    tmp = table(n+1,n+1);
    %minus out the x
    xs = x - xs;
    %make the lasts elements;
    xs = xs(1:(n));
    %get the prodcut of the result
    tmp = tmp * prod(xs);
    result = result + tmp;

    %% unoptimized code, using for-loop
    % for i = 1:(n-1)
    %     tmp = tmp * (x - xs(i));
    % end
    % result = result + tmp;


end