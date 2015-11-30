

%% definition of the robot
bodyDef = [0 0; 3 0;5 5; 0 3;0 0]; %0,0 is always the reference point

%% definition of the start and endPoint for reference point

startPoint = [1 1];
endPoint = [100 100];

%% definition of obsticles to be tested

ori_obsticles = cell(3,1);
ori_obsticles{1} = [6 4;4 4;4 5;6 5;6 4];
ori_obsticles{2} = [5 5;5 7;7 5;5 5];
%ori_obsticles{3} = [8 1;9 1;9 13;8 13;8 1];
ori_obsticles{3} = [6 8.5;4 8.5;4 9;6 9;6 8.5];
%ori_obsticles{3} = [4 4;4 0;4.5 0;6 4;4 4];


%% randomly generate obsticles
num = 2;
ori_obsticles = cell(num,1);
for i=1:1:num
    %pick a center
    while true
        power = randi(15) + 5;
        startPt = [randi(75) + 10 randi(75) + 10];
        %pick how many points it has
        ptNum = randi(3) + 5;
        points = randi(power,ptNum,2);
        points = points + repmat(startPt, size(points,1),1);
        %do a convex hull on it
        pt = findConvexHull(points);
        if size(pt,1) < 3
            continue;
        end
        break;
    end
    pt = [pt; pt(1,:)];
    ori_obsticles{i} = pt;
end

%% Step 1: build the configuration space
obsticles = buildConfigSpace(bodyDef, ori_obsticles);
%obsticles = collisionDetection(obsticles);

%% Step 2: build the visibility graph
[graph,locIndex] = createVisibilityGraph(startPoint, endPoint, obsticles);

%% Step 3: Find the shortest path
bestPath = dijkstraAlgo(startPoint, endPoint, graph, locIndex);

%% Step 4: draw the visibility graph
drawVisibilityGraph(startPoint,endPoint,obsticles,ori_obsticles, graph, locIndex, bestPath,bodyDef);