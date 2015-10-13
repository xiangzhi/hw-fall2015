%question 2.5
im = loadImage('../data/model_chickenbroth.jpg');
[locs, desc] = briefLite(im);

val = zeros(36,1);
rot = 0;

for i = 1:1:36
    tmp = imrotate(im,rot)
    [locs2, desc2] = briefLite(tmp);
    matches = briefMatch(desc, desc2);
    val(i) = size(matches,1);
    rot = rot + 10;
end

bar(val);