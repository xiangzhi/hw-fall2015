img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
M = max(size(img1));
F = eightpoint(pts1,pts2,M);

save('q2_1.mat','F','M','pts1','pts2');

displayEpipolarF(img1,img2,F);