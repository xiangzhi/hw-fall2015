img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M = max(size(img1));
F = eightpoint(pts1,pts2,M);

E = essentialMatrix(F,K1,K2);
%disp(real(E));

M1 = [eye(3),zeros(3,1)];
M2s = camera2(E);

%test = triangulate(pts1,pts2,M1,M2s(:,:,1));
%save('q2_2.mat','F','M','pts1','pts2');
triangulate(M1,pts1,M2s(:,:,4),pts2);
displayEpipolarF(img1,img2,F);