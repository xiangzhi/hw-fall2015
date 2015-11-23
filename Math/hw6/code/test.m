startPoint = [1 1];
endPoint = [10 15];

obsticles = cell(1,1);
obsticles{1} = [5 5;7 5;5 7;5 5];
graph = createVisibilityGraph(startPoint, endPoint, obsticles);
drawVisibilityGraph(startPoint,endPoint,obsticles, graph);