%question 1d

y = -1;
n = 0;
%the step size
h = -0.05;
%the given function
eq = @(x,y) 2/(x.^2 * (1 - y));


%save the previous fs;
f0 = eq(1.05,-0.951800146);
f1 = eq(1.1,-0.906925178);
f2 = eq(1.15,-0.865009616);
f3 = 0; %initial such that it saves over loop


%Ruuge-Kutter
for i=1:h:0
   
    %move the fs downwards
    f3 = f2;
    f2 = f1;
    f1 = f0;
    %calculate the new f0
    f0 = eq(i,y);
    %move the 
    %calculate the new Y
    newY = y + h/24 * (55 * f0 - 59 *f1 + 37 *f2 - 9*f3);
    fprintf('n:%d x:%f y:%f\n',n,i,y);
    y = newY;
    n = n + 1;
end