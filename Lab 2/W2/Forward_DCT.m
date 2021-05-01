function T = Forward_DCT(G)
    N = length(G);
    F = DCT_F(N);
    T = F*G*F';
end