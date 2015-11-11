function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

err = 0.005;
best = -Inf;
bestPicks = zeros(size(pts1,1),1);
for s=1:1:100
    picks = randperm(size(pts1,1),7);
    pts1Pick = pts1(picks,:);
    pts2Pick = pts2(picks,:);
    Fs = sevenpoint(pts1Pick, pts2Pick, M);
    for k=1:1:3
        F = real(Fs{k});
        
        dist = arrayfun(@(x2,y2,x1,y1) abs([x2 y2 1] * F * [x1;y1;1]),pts2(:,1),pts2(:,2),pts1(:,1),pts1(:,2));

        inliers = dist(:,1) < err;
        disp(sum(inliers));

        if(sum(inliers) > best)
            best = sum(inliers);
            bestPicks = inliers;
        end
        %get number of inliers.
        %tmp = pts2.*F
    end
end

pts1Pick = pts1(bestPicks,:);
pts2Pick = pts2(bestPicks,:);

F = eightpoint(pts1Pick, pts2Pick,M);





% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made



end

