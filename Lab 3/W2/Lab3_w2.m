%Week 2
%% CDF Transform Implementation and Verification
img = imread('lab3_p0101.pgm');

L=3;
img_transform = CDF2D_Forward_L(double(img),L);
disp_dwt(img_transform,L)

img_rev = CDF2D_Reverse_L(img_transform,L);
figure,imagesc(img_rev);
colormap(repmat(linspace(0,1,256)',1,3));
axis image;


%1 CDF
L = 3;
im_size = 64;
LL3 = zeros(im_size,im_size);
LL3((im_size/2^L)/2,(im_size/2^L)/2) = 255; %impulse 

LL3_basic= CDF2D_Reverse_L(LL3,L);

figure;
subplot(3,4,1)
imagesc(uint8(round(LL3_basic)));
title('LL3 - basis');
colormap(repmat(linspace(0,1,256)',1,3));
axis image;

count = 1;
for level = 0:L-1
    [HL,LH,HH] = deal(zeros(im_size,im_size));
    cor_1 = 2^level*12;
    cor_2 = 2^level*4;
    HL(cor_2,cor_1) = 255;
    LH(cor_1,cor_2) = 255;
    HH(cor_1,cor_1) = 255;
    HL_basis = CDF2D_Reverse_L(HL,L);
    LH_basis = CDF2D_Reverse_L(LH,L);
    HH_basis = CDF2D_Reverse_L(HH,L);
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(HL_basis)))
    title(sprintf('HL%d - basis',L-level));
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(LH_basis)))
    title(sprintf('LH%d - basis',L-level));
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(HH_basis)))
    title(sprintf('HH%d - basis',L-level));
    
end

%2 Haar
L = 3;
im_size = 64;
LL3 = zeros(im_size,im_size);
LL3((im_size/2^L)/2,(im_size/2^L)/2) = 255;% impulse

LL3_basic= Haar2D_Reverse_L(LL3,L);

figure;
subplot(3,4,1)
imagesc(uint8(round(LL3_basic)));
title('LL3 - basis');
colormap(repmat(linspace(0,1,256)',1,3));
axis image;

count = 1;
for level = 0:L-1
    [HL,LH,HH] = deal(zeros(im_size,im_size));
    cor_1 = 2^level*12;
    cor_2 = 2^level*4;
    HL(cor_2,cor_1) = 255;
    LH(cor_1,cor_2) = 255;
    HH(cor_1,cor_1) = 255;
    HL_basis = Haar2D_Reverse_L(HL,L);
    LH_basis = Haar2D_Reverse_L(LH,L);
    HH_basis = Haar2D_Reverse_L(HH,L);
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(HL_basis)))
    title(sprintf('HL%d - basis',L-level));
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(LH_basis)))
    title(sprintf('LH%d - basis',L-level));
    
    count = count+1;
    subplot(3,4,count)
    imagesc(uint8(round(HH_basis)))
    title(sprintf('HH%d - basis',L-level));
    
end

%% Bit-plane Coding Simulator

%CDF
img = imread('lab3_p0101.pgm');
L=5;
img_transform = CDF2D_Forward_L(double(img),L);

[n,m] = size(img);
ver = 6;
planes = zeros(n,m,ver);
L_2 = 5;

PSNR_CDF = zeros(1,6);

for eachV = 1:ver
    plane = bit_plane_coding(img_transform,eachV);
    planes(:,:,eachV) = plane;
    
    reverse = CDF2D_Reverse_L(plane,L_2);
    PSNR_CDF(eachV) = PSNR(img,reverse);
    
    figure, imagesc(uint8(round(reverse)));
    title(sprintf('CDF - %d',eachV));
    axis image;
end

%Haar
img = imread('lab3_p0101.pgm');
img_transform = Haar2D_Forward_L(double(img),L);

[n,m] = size(img);
planes = zeros(n,m,ver);

PSNR_Haar = zeros(1,6);

for eachV = 1:ver
    plane = bit_plane_coding(img_transform,eachV);
    planes(:,:,eachV) = plane;
    
    reverse = Haar2D_Reverse_L(plane,L_2);
    PSNR_Haar(eachV) = PSNR(img,reverse);
    
    figure, imagesc(uint8(round(reverse)));
    title(sprintf('Haar - %d',eachV));
    axis image;
end







