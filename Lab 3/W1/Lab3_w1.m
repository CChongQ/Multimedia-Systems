%3
img = imread('lab3_p0101.pgm');

%L-level, 2-D function to perform a 3-level Haar transform
img_transform = Haar2D_Forward_L(double(img),3);
disp_dwt(img_transform,3)