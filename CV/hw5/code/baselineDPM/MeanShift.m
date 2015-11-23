function [CCenters,CMemberships] = MeanShift(data,bandwidth,stopThresh)
% Weighted Mean-Shift Clustering

%start by randomly pick 5 % of the points as starting location from the data
startPicks = randperm(size(data,1),floor(size(data,1)*0.05));
CCenters = data(startPicks,1:end-1);
CMemberships = zeros(size(data,1),1);
%now run the mean shift algorithm code
while true
    
    %calculate the distance of each data point to each center
    dist = pdist2(CCenters(:,:),data(:,1:end-1));
    %find all points that is less than bandwidth
    indices = dist < bandwidth;
    %calculate the new mean
    oldCenter = CCenters;
    for i=1:1:size(CCenters,1)

        
        %new center calculate
        v1 = data(indices(i,:),1:end-1);
        v2 = repmat(data(indices(i,:),end),1,size(data,2)-1);
        v3 = sum(v1 .* v2, 1);
        CCenters(i,:) = v3 ./ sum(data(indices(i,:),end),1);
        CMemberships(indices(i,:)) = i;
    end
    disp(norm(CCenters - oldCenter));
    if norm(CCenters - oldCenter) < stopThresh
        break;
    end
    
    %merge the CCenters if they are close by
    dists = pdist2(CCenters,CCenters);
    NewCCenters = CCenters;
    indices = dists < bandwidth;
    for i=1:1:size(CCenters,1)
        NewCCenters(i,:) = sum(CCenters(indices(i,:),:),1) ./ size(CCenters(indices(i,:),:),1);
    end
    CCenters = unique(NewCCenters,'rows');
end
end

