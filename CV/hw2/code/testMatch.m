im2 = loadImage('../data/chickenbroth_01.jpg');
im1 = loadImage('../data/model_chickenbroth.jpg');
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2)
