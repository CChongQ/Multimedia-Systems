function null = show_mv(mv)

frame_sz = [288,352];
mb_sz = 16;

[col_idx row_idx] = meshgrid((mb_sz/2):mb_sz:frame_sz(2),(mb_sz/2):mb_sz:frame_sz(1));

row_idx = row_idx';
row_idx = row_idx(:);

col_idx = col_idx';
col_idx = col_idx(:);

figure; quiver(col_idx,row_idx,mv(:,2),mv(:,1));
axis ij
axis([1 frame_sz(2) 1 frame_sz(1)])