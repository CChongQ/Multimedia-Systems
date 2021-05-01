function psnr = PSNR(P,Q)
    P = double(P);
    Q = double(Q);
    mse = MSE(P,Q);
    psnr = 10 * log10(255^2/mse);
end