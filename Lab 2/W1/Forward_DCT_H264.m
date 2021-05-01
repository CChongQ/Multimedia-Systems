function T = Forward_DCT_H264(G)
    F = [1 1 1 1; 2 1 -1 -2;1 -1 -1 1; 1 -2 2 -1];
    T = F*G*F';
end