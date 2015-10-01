function [out] = besselFunction(z,t)
sum = 0;
for k=0:1:t
    up = (z.^2 * -1 /4).^k;
    down = factorial(k) * factorial(k+1);
    sum = sum + up/down;
end
out = sum * z/2;

end

