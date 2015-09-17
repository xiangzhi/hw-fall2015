%A1 = [2 1 3;2 1 2;5 5 5];
%A1 = [4 7 0;2 2 -6;1 2 1];
A1 = [4 7 0;2 2 -6;1 2 1];
disp(det(A1))
B1 = [18 -12 8]';
[u,s,v] = svd(A1);
disp(u);
disp(s);
disp(v);
s(1,1) = 1/s(1,1);
s(2,2) = 1/s(2,2);
s(3,3) = 1/s(3,3);
disp(s);
answer = v * s * u' * B1;
disp(answer);

disp(A1 * answer);

