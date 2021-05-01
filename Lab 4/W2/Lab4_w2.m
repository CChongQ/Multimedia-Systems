%% 1
load('sequence_P0101.mat');
QP = 2;
NumRepeat = 5;
len = size(sequence);
output = zeros(len);
load('Q_matrices.mat');

%encode the provided frames as an IPIPIP... sequence
for i = 1:30
    if mod(i,2) == 1 
        I_encode = I_picture_encoding(sequence(:,:,i), QP, Q_intra);
        output(:,:,i) = I_encode;
    else
        P_encode = P_picture_encoding(sequence(:,:,i), uint8(round(output(:,:,i-1))), QP, Q_intra,Q_inter);
        output(:,:,i) = P_encode;
    end
    
end
output_1 = uint8(round(output));
play_frames(output_1, NumRepeat);

%display the motion vectors for last frame
[Prediction, MotionVectors, Flag] = Sequential_MotionSearch(sequence(:,:,30), output_1(:,:,29));
show_mv(MotionVectors);

psnr_1 = PSNR(sequence(:,:,30),output_1(:,:,30));

%% 2
load('sequence_P0101.mat');
QP = 2;
NumRepeat = 5;
len = size(sequence);
output = zeros(len);
load('Q_matrices.mat');

% encode the provided frames as an IPPPPP... sequence.
I_encode = I_picture_encoding(sequence(:,:,1), QP, Q_intra);
output(:,:,1) = I_encode;

for i = 2:30
    P_encode = P_picture_encoding(sequence(:,:,i),uint8(round(output(:,:,i-1))), QP, Q_intra,Q_inter);
    output(:,:,i) = P_encode; 
end

output_2 = uint8(round(output));
play_frames(output_2, NumRepeat);

% display the motion vectors for last frame
[Prediction, MotionVectors, Flag] = Sequential_MotionSearch(sequence(:,:,30), output_2(:,:,29));
show_mv(MotionVectors);

psnr_2 = PSNR(sequence(:,:,30),output_2(:,:,30));
