function [obsticles] = collisionDetection(obsticles)
    
    while true
        %break if there is only one obsticle left
        if length(obsticles) == 1
            break;
        end
        changed = false; % we quit when there is no more changes
        % this is probably a stupid algorithm, but it works.
        
        for i=1:1:length(obsticles)
            curOb = obsticles{i};
            %now we check against every single other obsticles
            for j=i+1:1:length(obsticles)
                nxtOb = obsticles{j};
                
                %check every edge against each other
                
                interSectPoints = [];
                
                for x = 1:1:size(curOb,1) -1
                    %now we do the tests
                    startE = [curOb(x,:) curOb(x+1,:)];
                    %get the line equation of the line
                    slA = startE(2) - startE(4);
                    slB = startE(3) - startE(1);
                    slC = startE(1) * startE(4) - startE(3) * startE(2);

                    for y=1:1:size(nxtOb,1) - 1
                        obE = [nxtOb(y,:) nxtOb(y+1,:)];
                        %get the line equation of the obsticle
                        olA = obE(2) - obE(4);
                        olB = obE(3) - obE(1);
                        olC = obE(1) * obE(4) - obE(3) * obE(2);

                        %now we check if they overlap
                        interDet = slA  * olB - olA * slB;
                        if interDet == 0
                            %if they are parallel
                            
                            %they are parallel,
                            %ignore for now
                            continue;
                        else
                            ix = (olB * (-1 * slC) - slB * (-1 * olC))/interDet;
                            iy = (slA * (-1 * olC) - olA * (-1 * slC))/interDet;
                            %check if the intersection is on it.
                            if ix >= min([obE(1) obE(3)]) & ix <= max([obE(1) obE(3)])
                                if iy >= min([obE(2) obE(4)]) & iy <= max([obE(2) obE(4)])
                                    if ix >= min([startE(1) startE(3)]) & ix <= max([startE(1) startE(3)])
                                         if iy >= min([startE(2) startE(4)]) & iy <= max([startE(2) startE(4)])
                                            interSecPoints = [interSecPoints; ix iy y x];
                                             
                                             %nothing inside here
                                            
                                            %changed = true;
                                            %break;
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
                    end
                end
                
                %now we have a whole list of points where the objects
                if size(interSecPoints) > 0
                    changed = true;
                    %remove all points
                end
                
                
                %these two objects are overlapped
                if changed
                    %build combined object
                    obsticles{i} = buildObjectBorder([curOb;nxtOb]);
                    %reemove old cell
                    obsticles{j} = [];
                    obsticles =  obsticles(~cellfun('isempty',obsticles));
                end
            end
            if changed
                break;
            end
        end
        %only quit this loop if there is no changed in the last cycle.
        if changed == false
            break;
        end
    end
end