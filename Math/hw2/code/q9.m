id = fopen('paths.txt');
disp(id);
C = textscan(id,'%f');
temp = zeros(4900,1);
temp(:,:) = C{1,1};
%now convert the file into x,y format
paths = cell(49,1);
%convert to paths
for i = 1:1:49
    path_x = temp((i-1)*100 + 1:(i-1)*100 + 50,1);
    path_y = temp((i-1)*100 + 51:(i-1)*100 + 100,1);
    test = cat(2,path_x,path_y);
    paths{i,1} = test;
    path_x = zeros(50,1);
    path_y = zeros(50,1);
end
clf();
viscircles([5,5],1.5)
hold on
axis([0,12,0,12])
for i = 1:1:49
    plot(paths{i,1}(:,1),paths{i,1}(:,2),'y');
end



[newPath picked] = interpolatePath([0.8 1.8],paths);
%[newPath picked] = interpolatePath([2.2 1.0],paths);
%[newPath picked] = interpolatePath([2.7 1.4],paths);

plot(paths{picked(1),1}(:,1), paths{picked(1),1}(:,2),'b');
plot(paths{picked(2),1}(:,1), paths{picked(2),1}(:,2),'b');
plot(paths{picked(3),1}(:,1), paths{picked(3),1}(:,2),'b');


%line([paths{picked(1),1}(1,1),paths{picked(2),1}(1,1)],[paths{picked(1),1}(1,2),paths{picked(2),1}(1,2)]);
%line([paths{picked(1),1}(1,1),paths{picked(3),1}(1,1)],[paths{picked(1),1}(1,2),paths{picked(3),1}(1,2)]);
%line([paths{picked(2),1}(1,1),paths{picked(3),1}(1,1)],[paths{picked(2),1}(1,2),paths{picked(3),1}(1,2)]);



plot(newPath(:,1),newPath(:,2),'r');
% newPath = interpolatePath([2.2 1.0],paths);
% plot(newPath(:,1),newPath(:,2),'g');
% newPath = interpolatePath([2.7 1.4],paths);
% plot(newPath(:,1),newPath(:,2),'b');



hold off


