function snr = SNR(P,Q)
    P = double(P);
    Q = double(Q);
    P_norm = (P(:,:,1).^2 + P(:,:,2).^2 + P(:,:,3).^2)/3;
    mse = MSE(P,Q);
    [x,y,~] = size(P);
    n = x*y;
    snr = 10 * log10((sum(P_norm,'all')/n)/mse);
end