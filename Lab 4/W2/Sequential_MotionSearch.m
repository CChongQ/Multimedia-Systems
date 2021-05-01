function [Prediction, MotionVectors, Flag]=Sequential_MotionSearch(Target, Reference)
   [M,N] = size(Target);
    MB_size = 16;
    K = (M/MB_size) * (N/MB_size);%the number of MBs in the picture
    
    Prediction = zeros(M,N);
    MotionVectors = zeros(K,2);
    Flag = zeros(K,1);%By default, set the motion search flag to unsuccessful
   
    p=8;% search area size: -8 to 8
    Threshold = 2048;% SAD cost threshold 
    
    offset = zeros((2*p+1)^2, 2); % a matrix of candidate motion vector
    temp = 1;
    for x = -p:p
        for y = -p:p
            offset(temp,:) = [x,y];
            temp = temp+1;
        end
    end
    
    processed_k =1;
    for i=1:16:M
        for j = 1:16:N
            %For sequential search, we need to check every location in the given search area
            for k = 1:(2*p+1)^2
                offset_i = offset(k,1);
                offset_j = offset(k,2);
                if i+offset_i<1 || j+offset_j < 1 || i+offset_i > M-15 || j+offset_j > N-15
                    %Exclude reference location outside the reference frame boundaries
                    continue
                else
                    sad = SAD(Target,Reference,i,j,offset_i,offset_j);
                    if sad <=Threshold
                        % the candidate MB just tested have SAD greather than the SAD threshold
                        % searcch was success
                        if (Flag(processed_k) == 0)
                            MotionVectors(processed_k,:) = [offset_i,offset_j];
                            Flag(processed_k) = 1; 
                            Prediction(i:i+MB_size-1,j:j+MB_size-1) = Reference(i+offset_i:i+offset_i+MB_size-1,j+offset_j:j+offset_j+MB_size-1);
                        else
                            %Use the one producing smallest MV if found a tie in MV
                            magnitude_currentMV = norm(MotionVectors(processed_k,:));
                            manitude_new = norm(offset_i,offset_j);
                            if magnitude_currentMV > manitude_new
                                MotionVectors(processed_k,:) = [offset_i,offset_j];
                                Prediction(i:i+MB_size-1,j:j+MB_size-1) = Reference(i+offset_i:i+offset_i+MB_size-1,j+offset_j:j+offset_j+MB_size-1);
                            end
                        end
                    end 
                end
            end
            processed_k = processed_k+1;
        end
    end
end



