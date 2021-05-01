function null = play_frames(in,num_times)

in = uint8(in);

sz = size(in);
map = repmat(linspace(0,1,256)',1,3);

for ii = 1:sz(3)
    M(ii) = im2frame(in(end:-1:1,:,ii),map);
end

hf = figure;
set(hf, 'Units', 'pixels');
set(hf, 'Position', [300 300 sz(2) sz(1)]);
axis off;
movie(hf,M,num_times,30,[0 0 0 0]);