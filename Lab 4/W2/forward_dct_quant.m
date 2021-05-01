function Output=forward_dct_quant(Input,QP,Q_matrix)
    
%2D forward DCT
N =8; 
F = DCT_F(N); %8 × 8 2-D forward DCT
T = F*Input*F';

%Quantization
Output = round(T./(Q_matrix.*QP));

end 