function Output = P_picture_encoding(currrent_frame, reference_frame, QP, Q_Intra,Q_Inter)

%Only the prediction difference (the “error” or the residue) and motion vectors are encoded

[M,N] = size(currrent_frame);
Output = zeros(M,N);

% Run the sequential search first
[Prediction, MotionVectors, Flag] = Sequential_MotionSearch(currrent_frame, reference_frame);

currrent_frame = double(currrent_frame);
Prediction = double(Prediction);

processed_k = 1;

for i=1:16:M
    for j = 1:16:N
        
        if (Flag(processed_k) == 1) 
            %Encode prediction difference (i.e. residual)
            residual = currrent_frame(i:i+15,j:j+15) - Prediction(i:i+15,j:j+15);
            
            encode_1 = forward_dct_quant(residual(1:8,1:8),QP,Q_Inter);
            Output(i:i+7,j:j+7) = inverse_dct_quant(encode_1,QP,Q_Inter) + Prediction(i:i+7,j:j+7);
            
            encode_2 = forward_dct_quant(residual(1:8,9:16),QP,Q_Inter);
            Output(i:i+7,j+8:j+15) = inverse_dct_quant(encode_2,QP,Q_Inter) + Prediction(i:i+7,j+8:j+15);
            
            
            encode_3 = forward_dct_quant(residual(9:16,1:8),QP,Q_Inter);
            Output(i+8:i+15,j:j+7) = inverse_dct_quant(encode_3,QP,Q_Inter) + Prediction(i+8:i+15,j:j+7);
            
            encode_4 = forward_dct_quant(residual(9:16,9:16),QP,Q_Inter);
            Output(i+8:i+15,j+8:j+15) = inverse_dct_quant(encode_4,QP,Q_Inter) + Prediction(i+8:i+15,j+8:j+15);
            
        else
            %the input should be the current MB and Q Intra

            current_MB = currrent_frame(i:i+15,j:j+15);
            
            encode_1 = forward_dct_quant(current_MB(1:8,1:8),QP,Q_Intra);
            decode_1 = inverse_dct_quant(encode_1,QP,Q_Intra);
            Output(i:i+7,j:j+7) = decode_1;
            
            encode_2 = forward_dct_quant(current_MB(1:8,9:16),QP,Q_Intra);
            decode_2 = inverse_dct_quant(encode_2,QP,Q_Intra);
            Output(i:i+7,j+8:j+15) = decode_2;
            
            encode_3 = forward_dct_quant(current_MB(9:16,1:8),QP,Q_Intra);
            decode_3 = inverse_dct_quant(encode_3,QP,Q_Intra);
            Output(i+8:i+15,j:j+7) = decode_3;
            
            encode_4 = forward_dct_quant(current_MB(9:16,9:16),QP,Q_Intra);
            decode_4 = inverse_dct_quant(encode_4,QP,Q_Intra);
            Output(i+8:i+15,j+8:j+15) = decode_4;
            
        end
        processed_k = processed_k+1;
    end
end

Output = uint8(round(Output));

end

