%%  sequential search algorithm:
img_01_tgt = imread('lab4_wk1_p0101_tgt.pgm');
img_01_ref = imread('lab4_wk1_p0101_ref.pgm');
[Prediction, MotionVectors, Flag]=Sequential_MotionSearch(img_01_tgt, img_01_ref);
%Display the motion vectors
show_mv(MotionVectors)

%Display the predicted picture and the residual picture
figure, imagesc(round(uint8(Prediction)));
colormap(gray(256));
title('Predicted Picture-sequential')
axis image;

%residual: the difference between the current picture and the predicted
residual = double(img_01_tgt) - double(Prediction);
figure, imagesc(round(uint8(residual)));
colormap(gray(256));
title('Residual Picture-sequential')
axis image;

%Calculate the MSE of the predicted picture
P = double(Prediction);
Q = double(img_01_tgt);
[x,y,z] = size(P);
mse_sequential = sum((P-Q).^2, 'all')/(x*y*z);

%%  logarithmic search algorithm
img_01_tgt = imread('lab4_wk1_p0101_tgt.pgm');
img_01_ref = imread('lab4_wk1_p0101_ref.pgm');
[Prediction, MotionVectors, Flag]=Log_MotionSearch(img_01_tgt, img_01_ref);
%Display the motion vectors
show_mv(MotionVectors)

%Display the predicted picture and the residual picture
figure, imagesc(round(uint8(Prediction)));
colormap(gray(256));
title('Predicted Picture-logarithmic')
axis image;

%residual: the difference between the current picture and the predicted
residual = double(img_01_tgt) - double(Prediction);
figure, imagesc(round(uint8(residual)));
colormap(gray(256));
title('Residual Picture-logarithmic')
axis image;

%Calculate the MSE of the predicted picture
P = double(Prediction);
Q = double(img_01_tgt);
[x,y,z] = size(P);
mse_logarithmic = sum((P-Q).^2, 'all')/(x*y*z);