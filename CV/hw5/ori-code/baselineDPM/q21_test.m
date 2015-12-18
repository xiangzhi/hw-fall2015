clear all;
load('q21_data.mat');

bandwidth = 35;  % This is an example. You may need to adjust this value
threshold = bandwidth*0.01; % This is an example. You may need to adjust this value
[CCenters,CMemberships] = MeanShift(data,bandwidth,threshold);

save('q21_result.mat','CCenters', 'CMemberships');

%% Draw
clusterNum  = size(CCenters,1);
figure; hold on; axis equal
set(gcf,'color','w');
cc=hsv(clusterNum);
for cIdx = 1:clusterNum
    tempMembership = find(CMemberships == cIdx);
    plot(data(tempMembership,1),data(tempMembership,2),'.','color',cc(cIdx,:));

    tempCenter = CCenters(cIdx,:);
    plot(CCenters(cIdx,1),CCenters(cIdx,2),'k+','MarkerSize',10,'lineWidth',2)      
end

print('q21_clustering','-djpeg');
