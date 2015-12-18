function [coords mode] = runMyModec(model,img,torso)


% cropbox
cropbox = tbox2ubbox(torso);
imgc = uint8(subarray(img,cropbox));

%% main code part

%the main meat is here in this runing the trained model
[rightObj, rightMode] = runModel(imgc,model,model.params,false);
%now we get the stuff we need in the data
coords = flip_pts_lr(rightObj.pts(:,:),size(imgc,2));
%update the coordinates
coords = bsxfun(@plus, coords, cropbox(1:2)'+1);
%save the mode for reference
mode = rightMode;