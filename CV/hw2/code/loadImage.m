function [im] = loadImage(path)
%load an image and generate a scaled 0-1 greyscale
    im = imread(path);
    if size(im,3) == 3
        im = rgb2gray(im);
    end
    %scale the image to 0-1
    im = double(im)./double(255);
end

