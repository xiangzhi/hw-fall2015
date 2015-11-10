
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M = max(size(img1));
F = eightpoint(pts1,pts2,M);

E = essentialMatrix(F,K1,K2);

F1 = inv(K1)' * E * inv(K2);
%disp(real(E));

M1 = K1 * [eye(3),[0;0;0]];
M2s = camera2(E);

M2s(:,:,1) = K2 * M2s(:,:,1);
M2s(:,:,2) = K2 * M2s(:,:,2);
M2s(:,:,3) = K2 * M2s(:,:,3);
M2s(:,:,4) = K2 * M2s(:,:,4);
posTotal = -Inf;
best = 0;

%calculate the error and also find the best z

for i=1:1:size(M2s,3)
    
    P = triangulate_t(M1,pts1,M2s(:,:,i),pts2);
    
    scatter3(P(:,1), P(:,2), P(:,3));
    
    %find the P that has the most positive z
    tmp = sum(P(:,3) > 0);
    if tmp >= posTotal
        best = i;
        posTotal = tmp;
    end
    %calculate the errror
    errorSum = 0;
    for j=1:1:size(pts2,1)
        tp1 = M1 * [P(j,:)';1];
        tp1 = tp1./tp1(3);
        tp2 = M2s(:,:,i) * [P(j,:)';1];
        tp2 = tp2./tp2(3);
        errorSum = errorSum + norm(pts1(j) - tp1) + norm(pts2(j) - tp2);
    end
end
M2 = M2s(:,:,best);
P = triangulate_t(M1,pts1,M2,pts2);
%[P err] = triangulate(pts1,pts2,M1',M2s(:,:,1)');

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




figure;
subplot(1,2,1)
%make here your first plot
scatter(pts1(:,1), pts1(:,2),'MarkerEdgeColor','blue');
subplot(1,2,2)
scatter(tpts1(:,1), tpts1(:,2),'MarkerEdgeColor','red');

%save('q2_5.mat','M2','pts1','pts2','P');