function [refinedBBoxes] = nms(bboxes, bandwidth,K)
%Non-Maximum Suppression(NMS) algorithm

%add big numbers to the score
bboxes(:,end) = bboxes(:,end) + 1000;
%run Mean Shift
threshold = bandwidth*0.01; % same as q21
[clusterCenters,clusterMemberships] = MeanShift(bboxes,bandwidth,threshold);

%if we have more clusters than we like
%we pick those with the highest memberships
if size(clusterCenters,1) > K
    counts = zeros(size(clusterCenters,1),1);
    %go through all the centers and find their sums
    for i=1:1:size(clusterCenters,1)
        counts(i) = sum(clusterMemberships == i);
    end
    disp(counts);
    [~,I] = sort(counts);
    t = I > size(counts,1) - K;
    clusterCenters = clusterCenters(t,:);
end

refinedBBoxes = clusterCenters;
end

