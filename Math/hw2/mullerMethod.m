function [answer] = mullerMethod(x0,x1,x2,limit,maxLoop,fx)
%Implementation of muller method
%based on the algorithm at http://www.physics.arizona.edu/~restrepo/475A/Notes/sourcea-/node25.html
    h1 = x1 - x0;
    h2 = x2 - x1;
    d1 = (fx(x1) - fx(x0))/h1;
    d2 = (fx(x2) - fx(x1))/h2;
    d = (d2 - d1)/(h2 + h1);
    i = 2;
    E = 0;
    while i < maxLoop
        b = d2 + h2*d;
        D = sqrt(b.^2 - 4 * fx(x2) * d);
        real(D);
        %disp(D);
        %this chooses the sign based on what gives largest denominator.
        if abs(b-D) < abs(b+d)
            E = b + D;
        else
            E = b - D;
        end
        h = -2 * fx(x2)/E;
        p = x2 + h;
        %disp(p);
        %check if we have reach the end condition
        if abs(h) < limit
            answer = p;
            return
        end
        %disp(p);
        x0 = x1;
        x1 = x2;
        x2 = p;
        h1 = x1 - x0; %h1 = x1*x0;
        h2 = x2 - x1;
        d1 = (fx(x1) - fx(x0))/h1;
        d2 = (fx(x2) - fx(x1))/h2;
        d = (d2 - d1)/(h2 + h1);
        i = i + 2;
    end
    disp('FAILED');
end

