%assuming I already have matches loaded up
im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

format long g;

p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);
[h,m] = ransacH(matches, locs1, locs2, 100, 5);
%plotMatches(im1, im2, m, locs1, locs2)
disp(h);
%get the image
img = imageStitching(im1,im2,h);
imshow(img);
%save the stuff they want
imwrite(img,'../q6_1.jpg');
save('q6_1.mat','h');

img = imageStitching_noClip(im1,im2,h);
imshow(img);
imwrite(img,'../q6_2_pan.jpg');
