function rgb_image = ycc2rgb(ycc_image)
    Y = ycc_image(:,:,1);
    Cb = ycc_image(:,:,2);
    Cr = ycc_image(:,:,3);
    R = 1.0133*Y - 0.0025*(Cb-128) + 1.3838*(Cr-128);
    G = 1.0051*Y - 0.3336*(Cb-128) - 0.6928*(Cr-128);
    B = 1.0079*Y + 1.7318*(Cb-128) + 0.0047*(Cr-128);
    rgb_image(:,:,1)= R;
    rgb_image(:,:,2)= G;
    rgb_image(:,:,3)= B;
end