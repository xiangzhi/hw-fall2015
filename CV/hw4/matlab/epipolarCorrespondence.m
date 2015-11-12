function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

%first get the epipolar linem we reused the code in the displayEpipolarF

winSize = 3;
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

bestError = inf;
bestx = x1;
besty = y1;
testerr = size(maxHeight,1);
if l(1) ~= 0
    for k= winSize+1 : 1 : maxHeight-winSize
        %calculate the x
        tx2 = -(l(2) * k + l(3))/l(1);
        %round the x to the nearest integer.
        tx2 = round(tx2);
        %get the new window
        w_im2 = im2(k-winSize:k+winSize, tx2-winSize:tx2+winSize,:);
        %calculate the difference between the image window
        type = 'cityblock';
        diff = sum(sum(pdist2(double(w_im1(:,:,1)),double(w_im2(:,:,1)),type)));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,2)),double(w_im2(:,:,2)),type)));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,3)),double(w_im2(:,:,3)),type)));
        %weight the difference based on the difference in x and y,
        %since we are assuming there is little difference between image.
        diff = diff * (1 + (abs(tx2 - x1))/maxHeight + abs(k - y1)/maxHeight);
        
        if diff < bestError
            bestError = diff;
            bestx = tx2;
            besty = k;
        end
        testerr(k) = diff;
    end
else
    %this means the line is horizontal
    for k= winSize+1 : 1 : maxWidth-winSize
        %calculate the x
        ty2 =  -(l(1) * k + l(3))/l(2);
        %round to nearest interger
        ty2 = round(ty2);
        %calculate the image
        w_im2 = im2(ty2-winSize : ty2+winSize, k-winSize : k+winSize,:);
        %calculate the difference between the image window
        type = 'cityblock';
        diff = sum(sum(pdist2(double(w_im1(:,:,1)),double(w_im2(:,:,1)),type)));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,2)),double(w_im2(:,:,2)),type)));
        diff = diff + sum(sum(pdist2(double(w_im1(:,:,3)),double(w_im2(:,:,3)),type)));
        %weight the difference based on the difference in x and y,
        %since we are assuming there is little difference between image.
        diff = diff * (1 + (abs(k - x1))/maxHeight + abs(ty2 - y1)/maxHeight);
        
        if diff < bestError
            bestError = diff;
            bestx = k;
            besty = ty2;
        end
        testerr(k) = diff;
    end
end

x2 = bestx;
y2 = besty;

end

