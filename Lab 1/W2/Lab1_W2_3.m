%Load image
jbeans = imread('jbeans.ppm');
figure, image(jbeans);
title('jbeans - Original')

%convert jeans.ppm to YCbCr
jbeans_ycc = rgb2ycc(jbeans);

vars = [10^2,20^2,40^2,80^2,100^2];
randn('state',sum(100*clock)) ;

%a row represents data for a variance, each row has 3 columns: [MSE PSNR SNR]
y_result = zeros(length(vars),3);
Cb_result = zeros(length(vars),3);
Cr_reuslt = zeros(length(vars),3);

for i = 1:length(vars)
    sigma_square = vars(i);
    
    [ycc_corrupted_y,ycc_corrupted_Cb,ycc_corrupted_Cr] = deal(jbeans_ycc);
    %Y
    noise = randn(256)*sqrt(sigma_square);
    ycc_corrupted_y(:,:,1) = jbeans_ycc(:,:,1) + noise;
    %Cb
    noise = randn(256)*sqrt(sigma_square);
    ycc_corrupted_Cb(:,:,2) = jbeans_ycc(:,:,2) + noise;
    %Cr
    noise = randn(256)*sqrt(sigma_square);
    ycc_corrupted_Cr(:,:,3) = jbeans_ycc(:,:,3) + noise;
    
    %transform YCbCr image to RGB
    rgb_corrupted_y = uint8(round(ycc2rgb(ycc_corrupted_y)));
    rgb_corrupted_Cb = uint8(round(ycc2rgb(ycc_corrupted_Cb)));
    rgb_corrupted_Cr = uint8(round(ycc2rgb(ycc_corrupted_Cr)));
    
    %the three reconstructed, corrupted images for sigma^2 = 6400
    if sigma_square == 6400
        %Show image
        figure ,image(rgb_corrupted_y);
        title('Reconstructed - Y Corrupted');
        figure ,image(rgb_corrupted_Cb);
        title('Reconstructed - Cb Corrupted');
        figure ,image(rgb_corrupted_Cr);
        title('Reconstructed - Cr Corrupted');  
    end
    
    %Calculate the MSE, PSNR and SNR
    %Y
    y_mse = MSE(jbeans,rgb_corrupted_y);
    y_psnr = PSNR(jbeans,rgb_corrupted_y);
    y_snr = SNR(jbeans,rgb_corrupted_y);
    y_result(i,:) = [y_mse,y_psnr,y_snr];
    %Cb
    Cb_mse = MSE(jbeans,rgb_corrupted_Cb);
    Cb_psnr = PSNR(jbeans,rgb_corrupted_Cb);
    Cb_snr = SNR(jbeans,rgb_corrupted_Cb);
    Cb_result(i,:) = [Cb_mse,Cb_psnr,Cb_snr];
    %Cr
    Cr_mse = MSE(jbeans,rgb_corrupted_Cr);
    Cr_psnr = PSNR(jbeans,rgb_corrupted_Cr);
    Cr_snr = SNR(jbeans,rgb_corrupted_Cr);
    Cr_reuslt(i,:) = [Cr_mse,Cr_psnr,Cr_snr];
end

%plot the MSE values 
figure; hold on;
plot(vars,y_result(:,1),'DisplayName','Y');
plot(vars,Cb_result(:,1),'DisplayName','Cb'); 
plot(vars,Cr_reuslt(:,1),'DisplayName','Cr');
hold off;
title('MSE values of all the three corrupted images');
xlabel('variance');
ylabel('MSE');
legend;


%plot the PSNR values 
figure; hold on;
plot(vars,y_result(:,2),'DisplayName','Y');
plot(vars,Cb_result(:,2),'DisplayName','Cb'); 
plot(vars,Cr_reuslt(:,2),'DisplayName','Cr');
hold off;
title('PSNR values of all the three corrupted images');
xlabel('variance');
ylabel('PSNR');
legend;

%plot the SNR values 
figure; hold on;
plot(vars,y_result(:,3),'DisplayName','Y');
plot(vars,Cb_result(:,3),'DisplayName','Cb'); 
plot(vars,Cr_reuslt(:,3),'DisplayName','Cr');
hold off;
title('SNR values of all the three corrupted images');
xlabel('variance');
ylabel('SNR');
legend;


% %-------------------------------------------%
% %the three reconstructed, corrupted images for sigma^2 = 6400
% var2_temp = 6400; 
% [ycc_corrupted_y_temp,ycc_corrupted_Cb_temp,ycc_corrupted_Cr_temp] = deal(jbeans_ycc);
% %Y
% noise_temp = randn(256)*sqrt(var2_temp);
% ycc_corrupted_y_temp(:,:,1) = jbeans_ycc(:,:,1) + noise_temp;
% %Cb
% noise_temp = randn(256)*sqrt(var2_temp);
% ycc_corrupted_Cb_temp(:,:,2) = jbeans_ycc(:,:,2) + noise_temp;
% %Cr
% noise_temp = randn(256)*sqrt(var2_temp);
% ycc_corrupted_Cr_temp(:,:,3) = jbeans_ycc(:,:,3) + noise_temp;
% 
% %transform YCbCr image to RGB
% rgb_corrupted_y_temp = uint8(round(ycc2rgb(ycc_corrupted_y_temp)));
% rgb_corrupted_Cb_temp = uint8(round(ycc2rgb(ycc_corrupted_Cb_temp)));
% rgb_corrupted_Cr_temp = uint8(round(ycc2rgb(ycc_corrupted_Cr_temp)));
% 
% %Show image
% figure ,image(rgb_corrupted_y_temp);
% title('Reconstructed - Y Corrupted');
% figure ,image(rgb_corrupted_Cb_temp);
% title('Reconstructed - Cb Corrupted');
% figure ,image(rgb_corrupted_Cr_temp);
% title('Reconstructed - Cr Corrupted');


