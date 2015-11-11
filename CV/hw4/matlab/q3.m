img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M = max(size(img1));
F = eightpoint(pts1,pts2,M);
disp(F);
E = essentialMatrix(F,K1,K2);
disp(E);

M1 = K1 * [eye(3),[0;0;0]];
M2s = camera2(E);

%test = triangulate(pts1,pts2,M1,M2s(:,:,1));
%save('q2_2.mat','F','M','pts1','pts2');
P = triangulate_t(M1,pts1,M2s(:,:,2),pts2);
%[P err] = triangulate(pts1,pts2,M1',M2s(:,:,1)');

scatter3(P(:,1),P(:,2),P(:,3));

%[P err] = triangulate(pts1,pts2,M1',M2s(:,:,1)');
%displayEpipolarF(img1,img2,F);