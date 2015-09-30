function [answer] = newtonMethod(x,fx,ffx)
%Newton Method
prev = x;
while true
    
    x = x - fx(x)/ffx(x);
    disp(x);
    %break if it finds a local minimum
    if abs(prev - x) < 0.0001
        break;
    end
    prev = x;
end
answer = x;
end

