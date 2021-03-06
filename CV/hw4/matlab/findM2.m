img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
M = max(size(img1));

F = eightpoint(pts1,pts2,M);
E = essentialMatrix(F,K1,K2);

M1 = K1 * [eye(3),[0;0;0]];
M2s = camera2(E);
M2s(:,:,1) = K2 * M2s(:,:,1);
M2s(:,:,2) = K2 * M2s(:,:,2);
M2s(:,:,3) = K2 * M2s(:,:,3);
M2s(:,:,4) = K2 * M2s(:,:,4);

errorTotal = Inf;
posTotal = -Inf;
best = 0;

errorList = zeros(size(M2s,3),1);

%calculate the error and also find the best z
for i=1:1:size(M2s,3)
    %try triangulate with the current M
    P = triangulate(M1,pts1,M2s(:,:,i),pts2);
    %calculate the errror
    errorSum = 0;
    for j=1:1:size(pts2,1)
        tp1 = M1 * [P(j,:)';1];
        tp1 = tp1./tp1(3);
        tp2 = M2s(:,:,i) * [P(j,:)';1];
        tp2 = tp2./tp2(3);
        errorSum = errorSum + norm(pts1(j) - tp1) + norm(pts2(j) - tp2);
    end
    errorList(i) = errorSum;
    
    %find the P that has the most positive z, if they are the same, pick
    %the one with the least error
    tmp = sum(P(:,3) > 0);
    if tmp > posTotal
        best = i;
        posTotal = tmp;
        errorTotal = errorSum;
    elseif tmp == posTotal
        if errorSum < errorTotal
            best = i;
            posTotal = tmp;
            errorTotal = errorSum;
        end
    end
    
end

%disp(errorList);
%disp(M2s);

M2 = M2s(:,:,best);
P = triangulate(M1,pts1,M2,pts2);

save('q2_5.mat','M2','pts1','pts2','P');