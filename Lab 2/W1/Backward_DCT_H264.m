function G = Backward_DCT_H264(T)
    B = [1 1 1 1/2; 1 1/2 -1 -1; 1 -1/2 -1 1; 1 -1 1 -1/2];
    G = B*T*B';
end