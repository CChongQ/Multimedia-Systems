% Q1
a = zeros(10,10,3);
figure, image(a), axis image;
title('Lab1-W1-1.1')

%Q2
a(1:2:end,1:2:end,:) = 255;
a(2:2:end,2:2:end,:) = 255;
figure, image(uint8(a)),axis image; 
title('Lab1-W1-1.2')

%Q3
a(4:2:7,5:2:7,1) = 255;
a(5:2:7,4:2:7,1) = 255;
figure, image(uint8(a)),axis image;
title('Lab1-W1-1.3')

%Q4
x = 0+255*rand([256,256,3]); % ragne [0,255]
figure, image(uint8(round(x))),axis image;
title('Lab1-W1-1.4 rand image')
%Find mean intensity
R_mean = mean(x(:,:,1),'all');
G_mean = mean(x(:,:,2),'all');
B_mean = mean(x(:,:,3),'all');
%Replace intensity - R
R_temp = x(:,:,1);
R_temp(find(x(:,:,1)>R_mean)) = R_mean;
x(:,:,1) = R_temp;
%Replace intensity - G
G_temp = x(:,:,2);
G_temp(find(x(:,:,2)>G_mean)) = G_mean;
x(:,:,2) = G_temp;
%Replace intensity - B
B_temp = x(:,:,3);
B_temp(find(x(:,:,3)>B_mean)) = B_mean;
x(:,:,3) = B_temp;
%Generate a new colour image
figure, image(uint8(round(x))),axis image;
title('Lab1-W1-1.4')



