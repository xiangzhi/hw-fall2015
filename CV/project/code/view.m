load cluster_info.mat
figure
disp(length(cluster_info));
for i=1:1:6
    for j=1:1:6
        index = (i-1)*6 + j;
        if index > length(cluster_info.thumbs)
            break;
        end
        subplot(6,6,index);
        imshow(cluster_info.thumbs{index});
    end
end