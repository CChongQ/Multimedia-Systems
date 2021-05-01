% 1
lena = imread('lena512color.tiff');
figure, image(lena);
title('Original Image');
axis image;

%The original image 
lena_ycc = rgb2ycc(lena);

dim = 512;
lena_ycc_y = lena_ycc(:,:,1);
lena_ycc_Cb = lena_ycc(:,:,2);
lena_ycc_Cr = lena_ycc(:,:,3);
[T_y,T_Cb,T_Cr] = deal(zeros(dim));

Q_y = [16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77;
        24 36 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 107];
Q_CbCr = [17 18 24 47 99 99 99 99;
          18 21 26 66 99 99 99 99;
          24 26 56 99 99 99 99 99;
          47 66 99 99 99 99 99 99;
          99 99 99 99 99 99 99 99;
          99 99 99 99 99 99 99 99;
          99 99 99 99 99 99 99 99;
          99 99 99 99 99 99 99 100];
      
for u = 0:(dim/8-1)
    for v = 0: (dim/8-1)
        % 2
        y_block = lena_ycc_y(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cb_block = lena_ycc_Cb(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cr_block = lena_ycc_Cr(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        T_y_temp = Forward_DCT(y_block);
        T_Cb_temp = Forward_DCT(Cb_block);
        T_Cr_temp = Forward_DCT(Cr_block);
        %4
        T_y(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_y_temp,Q_y);
        T_Cb(8*u+1:(u+1)*8,8*v+1:(v+1)*8) =  Quantizer(T_Cb_temp,Q_CbCr);
        T_Cr(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_Cr_temp,Q_CbCr);
    end 
end 

%5
alpha = 5;
Q_y_a = Q_y.*alpha;
Q_CbCr_a = Q_CbCr.*alpha;
[T_y_a,T_Cb_a,T_Cr_a] = deal(zeros(dim));
for u = 0:(dim/8-1)
    for v = 0: (dim/8-1)
        % 2
        y_block = lena_ycc_y(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cb_block = lena_ycc_Cb(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cr_block = lena_ycc_Cr(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        T_y_temp = Forward_DCT(y_block);
        T_Cb_temp = Forward_DCT(Cb_block);
        T_Cr_temp = Forward_DCT(Cr_block);
        %4
        T_y_a(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_y_temp,Q_y_a);
        T_Cb_a(8*u+1:(u+1)*8,8*v+1:(v+1)*8) =  Quantizer(T_Cb_temp,Q_CbCr_a);
        T_Cr_a(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_Cr_temp,Q_CbCr_a);
    end 
end 

%6
[Q_y_R1,Q_y_R2,Q_CbCr_R1,Q_CbCr_R2] = deal(zeros(8));
R1 = [1,5];
R2 = [1,63];
for i=0:7
    for j= 0:7
        Q_y_R1(i+1,j+1) = 1+ (i^2+j^2)*R1(1);
        Q_CbCr_R1(i+1,j+1) = 1+ (i^2+j^2)*R1(2);
        
        Q_y_R2(i+1,j+1) = 1+ (i^2+j^2)*R2(1);
        Q_CbCr_R2(i+1,j+1) = 1+ (i^2+j^2)*R2(2);
    end
end

[T_y_R1,T_Cb_R1,T_Cr_R1,T_y_R2,T_Cb_R2,T_Cr_R2] = deal(zeros(dim));
for u = 0:(dim/8-1)
    for v = 0: (dim/8-1)
        % 2
        y_block = lena_ycc_y(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cb_block = lena_ycc_Cb(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        Cr_block = lena_ycc_Cr(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
        T_y_temp = Forward_DCT(y_block);
        T_Cb_temp = Forward_DCT(Cb_block);
        T_Cr_temp = Forward_DCT(Cr_block);
        %R1
        T_y_R1(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_y_temp,Q_y_R1);
        T_Cb_R1(8*u+1:(u+1)*8,8*v+1:(v+1)*8) =  Quantizer(T_Cb_temp,Q_CbCr_R1);
        T_Cr_R1(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_Cr_temp,Q_CbCr_R1);
        %R2
        T_y_R2(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_y_temp,Q_y_R2);
        T_Cb_R2(8*u+1:(u+1)*8,8*v+1:(v+1)*8) =  Quantizer(T_Cb_temp,Q_CbCr_R2);
        T_Cr_R2(8*u+1:(u+1)*8,8*v+1:(v+1)*8) = Quantizer(T_Cr_temp,Q_CbCr_R2);
    end 
end 

%7
% [G,G_a,G_R1,G_R2] = deal(zeros(dim,dim,3));
G = Reconstruct(T_y,T_Cb,T_Cr,Q_y,Q_CbCr,dim);
reconstructed_1 = uint8(round(ycc2rgb(G)));
figure, image(reconstructed_1);
title('Reconstructed - Using the recommended table values');
axis image;

G_a = Reconstruct(T_y_a,T_Cb_a,T_Cr_a,Q_y_a,Q_CbCr_a,dim);
reconstructed_2 = uint8(round(ycc2rgb(G_a)));
figure, image(reconstructed_2);
title('Reconstructed -Using the recommended table values with α = 5');
axis image;

G_R1 = Reconstruct(T_y_R1,T_Cb_R1,T_Cr_R1,Q_y_R1,Q_CbCr_R1,dim);
reconstructed_3 = uint8(round(ycc2rgb(G_R1)));
figure, image(reconstructed_3);
title('Reconstructed - Using the recommended table  with R = {1,5}');
axis image;

G_R2 = Reconstruct(T_y_R2,T_Cb_R2,T_Cr_R2,Q_y_R2,Q_CbCr_R2,dim);
reconstructed_4 = uint8(round(ycc2rgb(G_R2)));
figure, image(reconstructed_4);
title('Reconstructed - Using the recommended table  with R = {1,63}');
axis image;



%8 Calculate PSNE
PSNR_default = PSNR(lena,reconstructed_1);
PSNR_alpha = PSNR(lena,reconstructed_2);
PSNR_R1 = PSNR(lena,reconstructed_3);
PSNR_R2 = PSNR(lena,reconstructed_4);

