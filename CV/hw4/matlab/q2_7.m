load('../data/templeCoords.mat');


newPts = zeros(size(x1,1),2);
for i=1:1:size(x1)
    [newPts(i,1),newPts(i,2)] = epipolarCorrespondence(img1,img2,F,x1(i),y1(i));
 
    disp(i);
end

P = triangulate_t(M1,[x1 y1],M2, newPts);
scatter3(P(:,1), P(:,2), P(:,3));



% 
% load('../data/intrinsics.mat');
% M = max(size(img1));
% F = eightpoint(pts1,pts2,M);
% 
% E = essentialMatrix(F,K1,K2);
% %disp(real(E));
% 
% M1 = [eye(3),zeros(3,1)];
% M2s = camera2(E);
% 
% %test = triangulate(pts1,pts2,M1,M2s(:,:,1));
% %save('q2_2.mat','F','M','pts1','pts2');
% p2 = triangulate_t(M1,pts1,M2s(:,:,1),pts2);
% [P err] = triangulate(pts1,pts2,M1',M2s(:,:,1)');
% displayEpipolarF(img1,img2,F);