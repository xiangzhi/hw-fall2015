function warp_im = warpA(im, A, outSize)
% this is the warp function to warp the image based on A
% this was partly based on a quadtobox.m file 
% by Ian Matthews and Simon Baker.
% choose this since the normal imwarp function in matlab and the first
% assignments give weird and undesirable results



[x y] = meshgrid(1:outSize(2), 1:outSize(1));
cor = [reshape(x,prod(size(x)),1)'; reshape(y, prod(size(y)),1)'];
cor = [cor; ones(1, size(cor,2))];
    
%transform
cor = A * cor;

cor = cor(1:2,:)';

x = reshape(cor(:,1),outSize(1),outSize(2));
y = reshape(cor(:,2),outSize(1),outSize(2));

warp_im = interp2(im,x,y,'bilinear');
%find places where it's nan and replace with 0;
warp_im(isnan(warp_im)) = 0;

