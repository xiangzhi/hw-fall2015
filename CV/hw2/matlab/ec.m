im1 = loadImage('../results/ec8_1.jpg');
im2 = loadImage('../results/ec8_2.jpg');
im3 = loadImage('../results/ec8_3.jpg');
o_im1 = imread('../results/ec8_1.jpg');
o_im2 = imread('../results/ec8_2.jpg');
o_im3 = imread('../results/ec8_3.jpg');

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[locs3, desc3] = briefLite(im3);

matches = briefMatch(desc2, desc1);
[h] = ransacH(matches, locs2, locs1, 1000, 10);
disp(h);
img = imageStitching_noClip(o_im2,o_im1,h);
tot = img;

img = rgb2gray(img);
img = double(img)./double(255);
imshow(img);

[locs, desc] = briefLite(img);
matches = briefMatch(desc3, desc);
disp(size(matches));
[h] = ransacH(matches, locs3, locs, 1000, 5);
img = imageStitching_noClip(o_im3,tot,h);
imshow(img);

