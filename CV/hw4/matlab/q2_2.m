img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
pick= [49 12 104 1 83 86 91];
pts1 = pts1(pick,:);
pts2 = pts2(pick,:);
M = max(size(img1));

F = sevenpoint(pts1,pts2,M);

save('q2_2.mat','F','M','pts1','pts2');

displayEpipolarF(img1,img2,F{2});