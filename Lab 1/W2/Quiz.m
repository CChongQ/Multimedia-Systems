black_img = zeros(10,10,3);
white_img = ones(10,10,3);
P = uint8(round(double(white_img)));
Q = uint8(round(double(black_img)));

%calculate MSE
norm = ((P(:,:,1)-Q(:,:,1)).^2 + (P(:,:,2)-Q(:,:,2)).^2 + (P(:,:,3)-Q(:,:,3)).^2) / 3;
[x,y,~] = size(P);
n_2 = x*y;
mse = sum(norm,'all')/n_2;   
%Calculate SNR
P_norm = (P(:,:,1).^2 + P(:,:,2).^2 + P(:,:,3).^2)/3;
[a,b,~] = size(P);
n_1 = a*b;
snr = 10 * log10((sum(P_norm,'all')/n_1)/mse);

syms k x
F1 = symsum(3,k,1,256);

x = 0+255*rand([256,256,3]); % ragne [0,255]
A = imbinarize(x);
figure, image(uint8(A)),axis image;