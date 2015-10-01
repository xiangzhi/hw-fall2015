function [answer] = mullerMethod2(x0,x1,x2,limit,maxLoop,fx)
%Implementation of muller method
%based on the algorithm in Numerical Recipes in C on page 371.

    i = 1;
    while i < maxLoop
        q = (x2 - x1)/(x1 - x0);
        A = q*fx(x2) - q*(1+q)*fx(x1) + q.^2 * fx(x0);
        B = (2*q + 1)*fx(x2) - (1 + q).^2 * fx(x1) + q.^2 * fx(x0);
        C = (1 + q) * fx(x2);

        q = sqrt(B.^2 - 4*A*C);
        if abs(B-q) < abs(B+q)
            q = B + q;
        else
            q = B - q;
        end
        newX = x2 - (x2 - x1) * ((2 * C)/q);
        %check differences between old point
        if abs(x2 - newX) < limit
            answer = newX;
            return
        end

        x0 = x1;
        x1 = x2;
        x2 = newX;
        i = i + 1;
    end
    disp('FAILED');
end

