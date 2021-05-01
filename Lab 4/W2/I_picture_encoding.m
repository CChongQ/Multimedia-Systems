function Output = I_picture_encoding(currrent_frame, QP, Q_Intra)

    [M,N] = size(currrent_frame);
    currrent_frame = double (currrent_frame);
    Output = zeros(M,N);

    for i=1:16:M
        for j = 1:16:N
            %MB: 16x16, Q:8x8, so call the forward and inverse 2*2 times
            encode_1 = forward_dct_quant(currrent_frame(i:i+7,j:j+7),QP,Q_Intra);
            Output(i:i+7,j:j+7) = inverse_dct_quant(encode_1,QP,Q_Intra);

            encode_2 = forward_dct_quant(currrent_frame(i+8:i+15,j:j+7),QP,Q_Intra); 
            Output(i+8:i+15,j:j+7) = inverse_dct_quant(encode_2,QP,Q_Intra);

            encode_3 = forward_dct_quant(currrent_frame(i:i+7,j+8:j+15),QP,Q_Intra); 
            Output(i:i+7,j+8:j+15) = inverse_dct_quant(encode_3,QP,Q_Intra);

            encode_4 = forward_dct_quant(currrent_frame(i+8:i+15,j+8:j+15),QP,Q_Intra); 
            Output(i+8:i+15,j+8:j+15) = inverse_dct_quant(encode_4,QP,Q_Intra);

        end
    end 

    Output = uint8(round(Output));

end