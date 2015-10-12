% p = [-1 1 1 -1; -1 -1 1 1];
% p2 = p+4;
% disp(p2);
% h = computeH(p,p);
% h = h./h(3,3);
% disp(h);
% h = computeH(p1',p2');
% %disp(h);

im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');


p1 = locs1(matches(:,1),1:2);
p2 = locs2(matches(:,2),1:2);
%h = computeH(p1([1:10 222:229 370 487],:)',p2([1:10 222:229 370 487],:)');
[h,m] = ransacH(matches, locs1, locs2, 100, 20);
%plotMatches(im1, im2, m, locs1, locs2)
%h(2,3) = h(2,3)*-1;
%h(1,3) = h(1,3)*-1;
%h(1,3) = 53;
disp(h);
imageStitching(im1,im2,h);
% % p1 = locs1(matches(:,1),1:2);
% % p2 = locs2(matches(:,2),1:2);
% % d = p1 - p2;

