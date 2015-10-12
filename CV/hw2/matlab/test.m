% 
% im = imread('../data/chickenbroth_01.jpg');
% im = rgb2gray(im);
% imshow(im);
% hold on;
% %scale the image
% im = double(im)./double(255);
% [locs, desc] =  briefLite(im);
% for i=1:1:size(locs)
%     plot(locs(i,1),locs(i,2),'r.','MarkerSize',20) 
% end
% hold off;
% imagesc(desc);
% %disp(im);



% %image(im);
% pyramid = createGaussianPyramid(im, 1, sqrt(2), [-1 0 1 2 3 4]);
% 
% [pyramid, levels] = createDoGPyramid(pyramid,[-1 0 1 2 3 4]);
% r = computePrincipalCurvature(pyramid);
% locs = getLocalExtrema(pyramid,levels,r,0.03,12);
% %disp(r);
% %imagesc(normc(r));
% %displayPyramid(pyramid);

% im2 = loadImage('../data/chickenbroth_01.jpg');
% im1 = loadImage('../data/model_chickenbroth.jpg');
im1 = loadImage('../data/incline_L.png');
im2 = loadImage('../data/incline_R.png');
% % im1 = loadImage('../data/pf_scan_scaled.jpg');
% %im2 = loadImage('../data/pf_desk.jpg');
% %im2 = loadImage('../data/pf_floor_rot.jpg');
% % im2 = loadImage('../data/pf_stand.jpg');
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
% disp(matches);
% 
% p1 = locs1(matches(:,1),1:2);
% p2 = locs2(matches(:,2),1:2);
% h = computeH(p1',p2');
% plotMatches(im1, im2, matches([1:10 222:229 370 487]), locs1, locs2)
% %disp(matches);
% 

% p1 = locs1(:,1:2);
% p2 = locs2(:,1:2);
% 