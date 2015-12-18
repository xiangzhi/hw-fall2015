%% variables

imageDir = '../data/t0/';
index = 0;
maxFileNum = 159;
minScore = 5;
boxSize = 20;

%% start-up

startup; %load paths
%Load the models
model = loadvar('MODEC-model-full.mat','mdls'); %use the model since we only do it once in a while


%% first round MODEC
torso = [];
%loop untill we can find at least one body
while index < maxFileNum
    %get the first image
    fileName = sprintf('frame%04d.jpg',index);
    fileName = strcat(imageDir,fileName);
    colorCurImg = imread(fileName);
    %try detecting a torso
    [bounds_predictions,poselet_hits,torso_predictions] = poselets_lite_detect(colorCurImg);
    %see whether we successfully found a torso
    if max(torso_predictions.score) > minScore
        torso = rect2box(torso_predictions.bounds(:,1)');
        break;
    end
    index = index + 1;
end
%quit if we can never find the torso
if isempty(torso)
    return;
end

%run pose estimation on it 
[locs,mode] = runMyModec(model, colorCurImg, torso);

%% create information for tracking

%for torso tracking
torsoWidth = torso(3) - torso(1);
torsoHeight = torso(4) - torso(2);
torsoCenter = [(torso(3) + torso(1)/2) (torso(4) + torso(2)/2)];
torsoM = [1 0 torsoCenter(1);0 1 torsoCenter(2);0 0 1];

%for wrist tracking
%get the location of the wrist
handLoc = locs(:,end);
%build the hand matrix
mMatrix = [1 0 handLoc(1);0 1 handLoc(2);0 0 1];
prevM = mMatrix;


%% draw first image
%display the image
hold on
imshow(colorCurImg);
title(strcat('frame ',num2str(index)));
hold on
line(locs(1,:)',locs(2,:)','LineWidth',3);
plot(mMatrix(1,3),mMatrix(2,3),'b.','MarkerSize',30);
rectangle('Position',[torso(1) torso(2) (torso(3) - torso(1)) (torso(4) - torso(2))],'EdgeColor',[1 0 0],'LineWidth',1.5);
%rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)]);
hold off
index = index + 1;
drawnow();

load cluster_info.mat
imshow(cluster_info.thumbs{mode});



%% start tracking
prevImg = rgb2gray(colorCurImg);
while index < maxFileNum
    fileName = sprintf('frame%04d.jpg',index);
    fileName = strcat(imageDir,fileName);
    colorCurImg = imread(fileName);
    curImg = rgb2gray(colorCurImg);
    
    %run Lucas Kanade on 
    
    
%     %% translation only Lucas Kanade
%     
%     %run lucas kanade on the torso
%     [u,v] = LucasKanade(prevImg,curImg,torso);
%     %update the box
%     torso(1) = torso(1) + u;
%     torso(3) = torso(3) + u;
%     torso(2) = torso(2) + v;
%     torso(4) = torso(4) + v;
    
    %% Affine transform Lucas Kanade.
    tm = LucasKanadeAffine(prevImg, curImg, torsoM,[floor(torsoHeight), floor(torsoWidth)]);
    torsoM = [tm(1)+1 tm(3) tm(5);tm(2) tm(4)+1 tm(6);0 0 1];
    %update torso
    torso(1) = torso(1) + (tm(5) - (torsoCenter(1)));
    torso(3) = torso(3) + (tm(5) - (torsoCenter(1)));
    torso(2) = torso(2) + (tm(6) - (torsoCenter(2)));
    torso(4) = torso(4) + (tm(6) - (torsoCenter(2)));
    torsoCenter(1) = tm(5);
    torsoCenter(2) = tm(6);
    
    M = LucasKanadeAffine(prevImg, curImg, mMatrix,[boxSize* 2 boxSize*2]);
    prevImg = curImg;
    %update mMatrix
    mMatrix =[M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    
    %check if there is a big difference between the current M and previous
    %M
    if sqrt((M(5) - prevM(1,3)).^2 + (M(6) - prevM(2,3)).^2) > 25
        
        %[bounds_predictions,poselet_hits,torso_predictions] = poselets_lite_detect(colorCurImg);
        %ntorso = rect2box(torso_predictions.bounds(:,1)');
        %redo prediction
        [locs,mode] = runMyModec(model, colorCurImg, torso);
        %get the location of the wrist
        handLoc = locs(:,end);
        %build the hand matrix
        mMatrix = [1 0 handLoc(1);0 1 handLoc(2);0 0 1];
    end
    %update prevMatrix
    prevM = mMatrix;
    
    %display the image
    clf;
    hold on
    imshow(colorCurImg);
    title(strcat('frame ',num2str(index)));
    hold on
    plot(mMatrix(1,3),mMatrix(2,3),'b.','MarkerSize',30);
    rectangle('Position',[torso(1) torso(2) (torso(3) - torso(1)) (torso(4) - torso(2))],'EdgeColor',[1 0 0],'LineWidth',1.5);
    %rectangle('Position',[rect(1), rect(2), rect(3) - rect(1),rect(4)-rect(2)]);
    hold off
    index = index + 1;
    drawnow();
    if rem(index,10) == 0
        saveas(gcf,strcat('frame',num2str(index),'.jpg'));
    end
end
