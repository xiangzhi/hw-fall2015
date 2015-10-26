function M = LucasKanadeAffine(It, It1)
%Lucus Kanade tracking of the system


%first get the template from the image
template = im2double(It);
%imshow(template);

w = size(It,2);
h = size(It,1);

template = template(1:h,1:w);


% 4) Evaluate Jacobian - constant for affine warps
dW_dp = jacobian_a(w, h);

%get the gradient of the templates
[tGx, tGy] = gradient(template);

% 5) Compute steepest descent images, VT_dW_dp
VT_dW_dp = sd_images(dW_dp, tGx, tGy, 6, h, w);

% 6) Compute Hessian and inverse
H = hessian(VT_dW_dp, 6, w);
%disp(H);

%old stupid method, but just to be sure
hessianT = zeros(6,6);
steep = zeros([size(template) 6]);
for y = 0:1:h-1
    for x = 0:1:w-1
        test = [tGx(y+1,x+1) tGy(y+1,x+1)];
        %test = test * [j i 1 0 0 0;0 0 0 j i 1];
        test = test * [x 0 y 0 1 0;0 x 0 y 0 1];
        %test = test * [0 x 0 y 0 1;x 0 y 0 1 0];
        steep(y+1,x+1,:) = test;
        hessianT = hessianT + (test' * test);
    end
end
%disp(hessianT);
%disp(sum(sum(VT_dW_dp)));
%disp(sum(sum(sum(steep))));
invHessian = inv(hessianT);
M = zeros(1,6);

tmplt_pts = [1 1 320 320;1 240 240 1];

for i = 1:1:50
    
    %first warp the image
    %build the Mmatrix
    %Mmatrix =[M(1)+1 M(2) M(3);M(4) M(5)+1 M(6);0 0 1];
    %Mmatrix =[M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    mMatrix =[M(1) M(3) M(5);M(2) M(4) M(6)];
    %imshow(It1);
    %warp the image
    
    img = warp_a(im2double(It1), mMatrix, tmplt_pts);
    
    %img = warpA(im2double(It1),Mmatrix,size(template));
    %imshow(img);
    
    %compute error image
    err = img - template;
    %disp(sqrt(mean(err(:).^2)));

    %step 7 -- can do better than this
    top = zeros(6,1);
    for i = 1:1:size(err,1)
        for j=1:1:size(err,2)
            test = reshape(steep(i,j,:),1,6);
            top = top + (test' * err(i,j));
        end
    end
   
    %disp(top);
    
    %find delta p
    deltaP = invHessian * top;
    %disp(deltaP);
    %if( sqrt(mean(err(:).^2)) < 0.06)
    disp(norm(deltaP))
    if( norm(deltaP) <= 0.05)
        %imshow(img);
        break;
    end
    
    %now we update it
    %make a Mmatrix
%     deltaPmatrix = [deltaP(1)+1 deltaP(2) deltaP(3); ...
%         deltaP(4) deltaP(5)+1 deltaP(6);0 0 1];
    deltaPmatrix = [deltaP(1)+1 deltaP(3) deltaP(5); ...
        deltaP(2) deltaP(4)+1 deltaP(6);0 0 1];
    %inverse the matrix
    deltaPmatrix = inv(deltaPmatrix);
    %make the current matrix
    mMatrix = [M(1)+1 M(3) M(5);M(2) M(4)+1 M(6);0 0 1];
    %composition
    newMatrix = mMatrix * deltaPmatrix;
    newMatrix(1,1) = newMatrix(1,1) -1;
    newMatrix(2,2) = newMatrix(2,2) -1;
    %can't really use reshape since it messes up the way I do it
    %disp(newMatrix);
    M = reshape(newMatrix(1:2,:),1,6);
    %disp(M);
    %M = [newMatrix(1,:) newMatrix(2,:)];
end

disp(M);
