startPoint = [1 1];
endPoint = [10 15];

obsticles = cell(2,1);
obsticles{1} = [5 5;7 5;5 7;5 5];
obsticles{2} = [8 0;9 0;9 15;8 15;8 0];
[graph,locIndex] = createVisibilityGraph(startPoint, endPoint, obsticles);
drawVisibilityGraph(startPoint,endPoint,obsticles, graph, locIndex);