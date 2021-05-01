%Load the jbeans.ppm image
jbeans = imread('jbeans.ppm');
figure, image(jbeans);
title('jbeans - Original')

%convert jeans.ppm to YCbCr
jbeans_ycc = rgb2ycc(jbeans);

%Display Y channel
Y = jbeans_ycc(:,:,1);
figure, imagesc(Y);
colorbar;
title('jbeans - Y Channel');
%Display Cr channel
Cr = jbeans_ycc(:,:,3);
figure, imagesc(Cr);
colorbar;
title('jbeans - Cr Channel');

%convert the image back to the RGB colour space
jbeans_rgb = ycc2rgb(jbeans_ycc);
figure ,image(uint8(round(jbeans_rgb)));
title('Image Conversion - YCC to RGB');


