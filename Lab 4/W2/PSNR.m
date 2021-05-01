function psnr = PSNR(P,Q)
    P = double(P);
    Q = double(Q);
    [x,y,z] = size(P);
    mse = sum((P-Q).^2, 'all')/(x*y*z);
    psnr = 10 * log10(255^2/mse);
end