function [Prediction, MotionVectors, Flag]=Log_MotionSearch(Target, Reference)
[M,N] = size(Target);
disp([M,N])
MB_size = 16;
K = (M/MB_size) * (N/MB_size);%the number of MBs in the picture

Prediction = zeros(M,N);
MotionVectors = zeros(K,2);
Flag = zeros(K,1);%By default, set the motion search flag to unsuccessful

p=8;% search area size: -8 to 8
Threshold = 2048;% SAD cost threshold


processed_k =0;
for i=1:16:M
    for j = 1:16:N
        %the offset starting from p/2 from the first iteration
        %for every iteration, we only check +-1*offset pixel in each direction
        %if we find a region with lower SAD and the flag=1 (successful), we will start from the region in next iteration
        %the iterations will stop when the offset is smaller than 1
        offset = p/2; 
        i_true = i;
        j_true = j;
        processed_k = processed_k+1;
        while offset >1
            for x = -1:1
                i_offset = i_true + x*offset;
                for y = -1:1
                    j_offset = j_true + y*offset;
                    if i_offset<1 || j_offset < 1 || i_offset > M-15 || j_offset > N-15
                        %Exclude reference location outside the reference frame boundaries
                        continue
                    else
                        sad = SAD(Target,Reference,i_true,j_true,x*offset,y*offset);
                        if sad <=Threshold
                            % the candidate MB just tested have SAD greather than the SAD threshold
                            % searcch was successful
                            if (Flag(processed_k) == 0)
                                MotionVectors(processed_k,:) = [x*offset,y*offset];
                                Flag(processed_k) = 1;
                                Prediction(i_true:i_true+15,j_true:j_true+15) = Reference(i_offset:i_offset+15,j_offset:j_offset+15);
                                i_true = i_offset;
                                j_true = j_offset;
                            else
                                %Use the one producing smallest MV if found a tie in MV
                                magnitude_currentMV = norm(MotionVectors(processed_k,:));
                                manitude_new = norm(x*offset,y*offset);
                                if magnitude_currentMV > manitude_new   
                                    MotionVectors(processed_k,:) = [x*offset,y*offset];
                                    Prediction(i_true:i_true+15,j_true:j_true+15) = Reference(i_offset:i_offset+15,j_offset:j_offset+15);
                                    i_true = i_offset;
                                    j_true = j_offset;
                                end
                            end
                        end
                    end
                    
                end
            end
            offset  = offset/2;
        end
    end
end

end