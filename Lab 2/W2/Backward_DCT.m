function G = Backward_DCT(T)
    N = length(T);
    B = DCT_B(N);
    G = B*T*B';
end