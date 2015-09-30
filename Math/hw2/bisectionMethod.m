function [root] = bisectionMethod(a,b,fx,limit)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
    while true
        %calculate the midpoint
        c = 0.5 * (a + b);
        %termination conditions
        val = fx(c);
        if val == 0 || (a-c) <= limit
            root = c;
            return;
        end
        
        valA = fx(a);
        if( valA > 0 && val < 0 )||(valA < 0 && val > 0 || valA == 0 || val == 0)
            b = c;
        else
            a = c;
        end
    end
end

