P = imread('jbeans.ppm');
Q = imread('jbeans_corrupted_sample.ppm');
mse = MSE(P,Q);
psnr = PSNR(P,Q);
snr = SNR(P,Q);