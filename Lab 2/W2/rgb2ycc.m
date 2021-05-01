function ycc_image = rgb2ycc(rgb_image)
    rgb_image = double(rgb_image);
    R = rgb_image(:,:,1);
    G = rgb_image(:,:,2);
    B = rgb_image(:,:,3);
    Y = ((75*R + 150*G + 29*B)/256);
    Cb = ((-44*R - 87*G + 131*B)/256) + 128;
    Cr = ((130*R - 110*G - 21*B)/256) + 128;
    ycc_image(:,:,1)= Y;
    ycc_image(:,:,2)= Cb;
    ycc_image(:,:,3)= Cr;
end