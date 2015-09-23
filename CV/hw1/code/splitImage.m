function output = splitImage(input, layer)
%Helper function that plits the image into smaller images
    
    %base case 
    if layer <= 0
        output = input;
        return
    end
    
    %the normal case, where the image is at the lowest level
    if size(input,1) == 1 && size(input,2) == 1
         %disp('normal case');
         h = size(input{1,1},1);
         w = size(input{1,1},2);
         h1 = round(h/2);
         h2 = h - h1;
         w1 = round(w/2);
         w2 = w - w1;
         output = mat2cell(input{1,1},[h1,h2],[w1,w2]);
         output = splitImage(output,layer - 1);
         return
    end
    %the recursive case where we going through multiple units
    output = cell(2,2);
    for i = 1:size(input,1)
        for j = 1:size(input,2)
            %fprintf('i:%d, j:%d\n',i,j);
            output{i,j} = splitImage(input(i,j),layer);
        end
    end
end

