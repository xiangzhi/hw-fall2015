function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

%first get the epipolar linem we reused the code in the displayEpipolarF

winSize = 10;
maxWidth = size(im1,2);
maxHeight = size(im1,1);

%get the line equation
l = F * [x1;y1;1];
%make sure the size if valid
s = sqrt(l(1)^2+l(2)^2);

if s==0
    disp('error');
end

l = l/s;

% %get window in image
w_im1 = im1(max(0,y1-winSize):min(maxHeight, y1 + winSize), ...
    max(0,x1-winSize):min(maxWidth,x1+winSize),:);

%im1 = im2double(im1);

% itX = linspace(max(0,y1-winSize),min(maxHeight, y1 + winSize),winSize * 2 + 1);
% itY = linspace(max(0,x1-winSize),min(maxWidth,x1+winSize),winSize * 2 + 1);
% w_im1(:,:,1) = interp2(im1(:,:,1),itY',itX);
% w_im1(:,:,2) = interp2(im1(:,:,2),itY',itX);
% w_im1(:,:,3) = interp2(im1(:,:,3),itY',itX);



bestError = inf;
bestx = x1;
besty = y1;
if l(1) ~= 0
    for k= winSize+1 : 1 : maxHeight-winSize
        %calculate the x
        tx2 = -(l(2) * k + l(3))/l(1);
        tx2 = floor(tx2);
        w_im2 = im2(k-winSize:k+winSize, tx2-winSize:tx2+winSize,:);
        %calculate the difference between the image window
        %diff = sum(sum(sum(w_im1 - w_im2)));
        
        diff = sum(sum(pdist2(double(w_im1(:,:,1)),double(w_im2(:,:,1)))));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,2)),double(w_im2(:,:,2)))));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,3)),double(w_im2(:,:,3)))));
        
        if diff < bestError
            bestError = diff;
            bestx = tx2;
            besty = k;
        end
    end
else
    for k= winSize+1 : 1 : maxWidth-winSize
        %calculate the x
        ty2 =  -(l(1) * k + l(3))/l(2);
        ty2 = floor(ty2);
        w_im2 = im2(ty2-winSize : ty2+winSize, k-winSize : k+winSize,:);
        %calculate the difference between the image window
        
        diff = sum(sum(pdist2(double(w_im1(:,:,1)),double(w_im2(:,:,1)))));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,2)),double(w_im2(:,:,2)))));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,3)),double(w_im2(:,:,3)))));
        
        if diff < bestError
            bestError = diff;
            bestx = ty2;
            besty = k;
        end
    end
end

x2 = bestx;
y2 = besty;

end

