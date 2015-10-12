function [im] = loadImage(path)
    im = imread(path);
    if size(im,3) == 3
        im = rgb2gray(im);
    end
    %scale the image to 0-1
    im = double(im)./double(255);
end

