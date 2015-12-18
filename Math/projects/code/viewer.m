clf;
hold on
effector = csvread('test/test1-endEffector.csv');
scatter3(effector(:,2),effector(:,3),effector(:,4),'MarkerFaceColor','black');

startP = 1370
endP = 1520
scatter3(effector(startP:endP,2),effector(startP:endP,3),effector(startP:endP,4),'MarkerFaceColor','red');

hold off