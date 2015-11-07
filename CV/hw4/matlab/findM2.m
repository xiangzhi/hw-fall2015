
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M = max(size(img1));
F = eightpoint(pts1,pts2,M);

E = essentialMatrix(F,K1,K2);

F1 = inv(K1)' * E * inv(K2);
%disp(real(E));

M1 = [eye(3),zeros(3,1)];
M2s = camera2(E);

error = Inf;
best = 0;
for i=1:1:size(M2s,1)
    P = triangulate_t(M1,pts1,M2s(:,:,i),pts2);
    %calculate the errror
    errorSum = 0;
    for j=1:1:size(pts2,1)
        tp1 = M1 * [P(j,:)';1];
        tp1 = tp1./tp1(3);
        tp2 = M2s(:,:,i) * [P(j,:)';1];
        tp2 = tp2./tp2(3);
        errorSum = errorSum + norm(pts1(j) - tp1) + norm(pts2(j) - tp2);
    end
    
    if errorSum < error
        best = i;
        error = errorSum;
    end
end
M2 = M2s(:,:,best);
P2 = triangulate_t(M1,pts1,M2,pts2);

[P err] = triangulate(pts1,pts2,M1',M2');

tpts1 = zeros(size(pts2));
tpts2 = zeros(size(pts2));
for j=1:1:size(pts2,1);
    tp1 = M1 * [P(j,:)';1];
    tp1 = tp1./tp1(3);
    tpts1(j,:) = tp1(1:2)';
    tp2 = M2 * [P(j,:)';1];
    tp2 = tp2./tp2(3);
    tpts2(j,:) = tp2(1:2)';
end



hold on
scatter(pts1(:,1), pts1(:,2));
scatter(tpts1(:,1), tpts1(:,2),'MarkerEdgeColor','blue');
hold off

%save('q2_5.mat','M2','pts1','pts2','P');