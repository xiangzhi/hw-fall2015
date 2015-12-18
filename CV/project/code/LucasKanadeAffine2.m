function [M] = LucasKanadeAffine2(It, It1, rect)
%LUCASKANADEAFFINE Summary of this function goes here
%   Detailed explanation goes here

epsilon = .001;
It = im2double(It);
It1 = im2double(It1);

%first get the template from the image
%get the height and width,+1 due to being inclusive
height = rect(4) - rect(2) + 1;
width = rect(3) - rect(1) + 1;
%create the iterators for the interpolation
itX = linspace(rect(2),rect(4),height);
itY = linspace(rect(1),rect(3),width);

%first get the template from the image
It = interp2(im2double(It(:,:,1)),itY',itX);




% compute the gradient of the template
[Tx, Ty] = gradient(It);

% compute the jacobian
% For affine with p = [p1 p2 p3; p4 p5 p6]
% 
% J = [x y 1 0 0 0; 0 0 0 x y 1]
[R, C] = size(It);
jacobian_x = repmat(0:C-1, R, 1);
jacobian_y = repmat([0:R-1]', 1, C);

% compute the steepest descent images
sdImages = zeros(R, 6*C);
sdImages(:,1:C) = Tx.*jacobian_x;
sdImages(:,C+1:2*C) = Ty.*jacobian_x;
sdImages(:,2*C+1:3*C) = Tx.*jacobian_y;
sdImages(:,3*C+1:4*C) = Ty.*jacobian_y;
sdImages(:,4*C+1:5*C) = Tx;
sdImages(:,5*C+1:end) = Ty;

% compute the Hessian
H = computeHessian(sdImages, 6, C);
Hinv = inv(H); % precompute the inverse

p = zeros(6,1);
deltaP = repmat(inf, 6, 1);
iter = 1;
while norm(deltaP) > epsilon && iter < 20;
    % compute the warped image
    M = constructM(p);
    
    interVectorX = linspace(rect(2),rect(4),height);
    interVectorY = linspace(rect(1),rect(3),width);
    %Build the vector array
    orectPtrs =  [interVectorX;interVectorY;ones(size(interVectorX))];
    rectPtrs = M * orectPtrs;
    scatter(rectPtrs(1,:)',rectPtrs(2,:)');
    warp_im = interp2(im2double(It1),rectPtrs(2,:),rectPtrs(1,:)');
    imshow(warp_im);
    
    
    
    
    
    % compute the error image
    % I am implicitly only using the pixels in the overlapping region
    % of the warped image and the template image. The warped image is the
    % same size as the template image. Any pixel not in the warped image
    % has a value of 0, so the multiplication will cancel out any terms
    % from 
    errorImage = warp_im - It;
    
    % compute step 7 of the algorithm
    summedImage = zeros(6,1);
    for i=1:6
        sdImage = sdImages(:, (i-1)*C+1:((i-1)+1)*C);
        summedImage(i) = sum(sum(sdImage .* errorImage));
    end
    
    % solve for deltaP
    deltaP = Hinv * summedImage;
    
    p = updateP(p, deltaP);
    
%     disp(norm(deltaP));
%     
%     M = constructM(p);
%     warp_im = quadtobox(It1, outputCorners, M, 'bilinear');
%     imshow(warp_im);
%     waitforbuttonpress;
    iter = iter + 1;
end

M = constructM(p);

end

function newp = updateP(p, deltaP)
    % the paper indices are different
    % so I have to swap some things around
    deltaP = reshape(deltaP,2,3);
    deltaP = [deltaP(1,:) deltaP(2,:)]';

    % construct the warp
    deltaM = constructM(deltaP);
    
    % invert the warp
    deltaMinv = inv(deltaM);
    
    % compute the current warp
    M = constructM(p);
    
    % compose the two warps
    newM = M * deltaMinv;
    
    % extract the p values
    newp = [newM(1, 1:3) newM(2,1:3)]';
    newp(1) = newp(1) - 1;
    newp(5) = newp(5) - 1;
end