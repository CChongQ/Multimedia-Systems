function Output=inverse_dct_quant(Input,QP,Q_matrix)

%Reverse Quantization
T_h =  Input.*QP.* Q_matrix;

%2D Reverse DCT
N =8; 
F = DCT_F(N);
B = F.';
Output = B*T_h*B';

end