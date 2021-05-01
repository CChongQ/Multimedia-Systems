function disp_dwt(in,L)

[m,n] = size(in);

fig = figure('Units','pixels');  
imagesc(in);
%imwrite(scale(in,0,1),'out1.bmp');
colormap(repmat(linspace(0,1,256)',1,3));
axis image;
set(fig,'Position',[5,100,m,n+40]);
axis off;
set(gca,'Position',[0 0 1 n/(n+40)]);
title('Original DWT');

sz = size(in);
in_scale = zeros(sz);

for ii = 1:L
    temp = in((sz(1)/2+1):sz(1),1:(sz(2)/2));
    low = min(min(temp)); high = max(max(temp));
    temp = (temp-low)/(high-low);
    in_scale((sz(1)/2+1):sz(1),1:(sz(2)/2)) = temp;
    
    temp = in(1:(sz(1)/2),(sz(2)/2+1):sz(2));
    low = min(min(temp)); high = max(max(temp));
    temp = (temp-low)/(high-low);
    in_scale(1:(sz(1)/2),(sz(2)/2+1):sz(2)) = temp;
    
    temp = in((sz(1)/2+1):sz(1),(sz(2)/2+1):sz(2));
    low = min(min(temp)); high = max(max(temp));
    temp = (temp-low)/(high-low);
    in_scale((sz(1)/2+1):sz(1),(sz(2)/2+1):sz(2)) = temp;
    
    sz = sz/2;
end

sz = sz*2;
temp = in(1:(sz(1)/2),1:(sz(2)/2));
low = min(min(temp)); high = max(max(temp));
temp = (temp-low)/(high-low);
in_scale(1:(sz(1)/2),1:(sz(2)/2)) = temp;
imwrite(in_scale,'out2.bmp');
fig = figure('Units','pixels');
imagesc(in_scale);
colormap(repmat(linspace(0,1,256)',1,3));
axis image;
set(fig,'Position',[5+m+10,100,m,n+40]);
axis off;
set(gca,'Position',[0 0 1 n/(n+40)]);
title('Maximum Contrast DWT');