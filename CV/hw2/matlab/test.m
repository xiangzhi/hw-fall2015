
im = imread('../data/model_chickenbroth.jpg');
im = rgb2gray(im);
imshow(im);
hold on;
%scale the image
im = double(im)./double(255);
[locs, pyramid] = DoGdetector(im,1,sqrt(2),[-1 0 1 2 3 4],0.03,12);
for i=1:1:size(locs)
    plot(locs(i,1),locs(i,2),'r.','MarkerSize',20) 
end
hold off;
%disp(im);


% %image(im);
% pyramid = createGaussianPyramid(im, 1, sqrt(2), [-1 0 1 2 3 4]);
% 
% [pyramid, levels] = createDoGPyramid(pyramid,[-1 0 1 2 3 4]);
% r = computePrincipalCurvature(pyramid);
% locs = getLocalExtrema(pyramid,levels,r,0.03,12);
% %disp(r);
% %imagesc(normc(r));
% %displayPyramid(pyramid);