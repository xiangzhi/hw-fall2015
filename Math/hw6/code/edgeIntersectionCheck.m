function [cleanEdges] = edgeIntersectionCheck(edges, obsticleEdges)
%https://www.topcoder.com/community/data-science/data-science-tutorials/geometry-concepts-line-intersection-and-its-applications/
%Check whether edges intersect
cleanEdges = [];
for i = 1:1:size(edges,1)
    %now we do the tests
    fail = false;
    startE = edges(i,:);
    %get the line equation of the line
    slA = startE(2) - startE(4);
    slB = startE(3) - startE(1);
    slC = startE(1) * startE(4) - startE(3) * startE(2);
    
    for j=1:1:size(obsticleEdges,1)
        obE = obsticleEdges(j,:);
        %get the line equation of the obsticle
        olA = obE(2) - obE(4);
        olB = obE(3) - obE(1);
        olC = obE(1) * obE(4) - obE(3) * obE(2);

        %now we check if they overlap
        interDet = slA  * olB - olA * slB;
        if interDet == 0
            %they are parallel
            %for now all parallel are okay
            continue;
        else
            ix = (olB * (-1 * slC) - slB * (-1 * olC))/interDet;
            iy = (slA * (-1 * olC) - olA * (-1 * slC))/interDet;

            %ignore if the intersection point is at the end points
            if (ix == obE(1) & iy == obE(2))|(ix == obE(3) & iy == obE(4))
                continue
            end
            if (ix == startE(1) & iy == startE(2))|(ix == startE(3) & iy == startE(4))
                continue
            end
            
            if ix >= min([obE(1) obE(3)]) & ix <= max([obE(1) obE(3)])
                if iy >= min([obE(2) obE(4)]) & iy <= max([obE(2) obE(4)])
                    if ix >= min([startE(1) startE(3)]) & ix <= max([startE(1) startE(3)])
                         if iy >= min([startE(2) startE(4)]) & iy <= max([startE(2) startE(4)])
                            %nothing inside here
                            fail = true;
                         else
                             continue;
                         end
                    else
                        continue;
                    end
                else
                    continue;
                end
            else
                continue;
            end
        end
        fail = true;
        break;
    end
    
    if ~fail
        cleanEdges = [cleanEdges;edges(i,:)];
    end
end 

end

