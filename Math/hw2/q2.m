% 
% xs = [1,1.5,2,2.5,3,3.5,4];
% 
% fxs = zeros(length(xs),1);
% %calculate fxs
% for i = 1:length(xs)
%     tmp = log10(xs(i))/log10(7);
%     %square it
%     fxs(i) = tmp * tmp;
% end
% disp(fxs);
% r = dividedDifferences(length(xs)-1,2.25,xs,fxs);
% disp(r);
% %real answer
% disp((log10(2.25)/log10(7)).^2);

% disp('real answer');
% disp(5/(1 + 36 * (0.05).^2));
% 
% 
% n = 40;
% xs = zeros(n+1,1);
% fxs = zeros(n+1,1);
% for i = 0:n
%     xs(i+1) = i * 2/n - 1;
%     fxs(i+1) = 5/(1 + 36 * xs(i+1).^2);
% end
% r = dividedDifferences(n,0.05,xs,fxs);
% disp(r);


n = 40;
xs = zeros(n,1);
fxs = zeros(n,1);
for i = 0:n
    xs(i+1) = i * 2/n - 1;
    fxs(i+1) = 5/(1 + 36 * xs(i+1).^2);
end
disp(xs);
max = 0;
points = zeros(1000,2);
ori = zeros(1000,2);
i = 1;
for x = -1:.001:1
    r = dividedDifferences(n,x,xs,fxs);
    %disp(r);
    %calculate the actual
    real = 5/(1 + 36 * x.^2);
    %disp(real);
    tmp = abs(real - r);
    %disp(tmp);
    if tmp > max
        max = tmp;
    end
    points(i,:) = [x, r];
    ori(i,:) = [x, real];
    i = i+1;
end
plot(points(:,1),points(:,2),ori(:,1),ori(:,2));
disp('max:');
disp(max);

