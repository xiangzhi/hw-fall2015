%assuming I already have matches loaded up
im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

format long g;

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);
H2to1 = ransacH(matches, locs1, locs2, 100, 10);
%plotMatches(im1, im2, m, locs1, locs2)
disp(H2to1);
%get the image
img = imageStitching(im1,im2,H2to1);
imshow(img);
%save the stuff they want
imwrite(img,'../q6_1.jpg');
save('q6_1.mat','H2to1');

img = imageStitching_noClip(im1,im2,H2to1);
imshow(img);
imwrite(img,'../q6_2_pan.jpg');
