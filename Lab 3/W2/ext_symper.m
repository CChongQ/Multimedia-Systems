function out = ext_symper(in,L_left,L_right)
% function out = ext_symper(in,L_left,L_right)
%
% © Karl Martin 2003
% Multimedia Lab,
% University of Toronto

N = length(in);
sz = size(in);

if sz(1) > 1
    in = in';
end

if L_left > (N-1)
    num_left = ceil(L_left/(2*N-2));
    left_part = [in,fliplr(in(2:(N-1)))];
    left_full = repmat(left_part,1,num_left);
    in_left = left_full(((2*N-2)*num_left-L_left+1):((2*N-2)*num_left));
else
    in_left = in((L_left+1):-1:2);
end
    
if L_right > (N-1)
    num_right = ceil(L_right/(2*N-2));
    right_part = [fliplr(in(2:(N-1))),in];
    right_full = repmat(right_part,1,num_right);
    in_right = right_full(1:L_right);
else
    in_right = in((N-1):-1:(N-L_right));
end

in_ext = [in_left,in,in_right];

if sz(1) > 1
    out = in_ext';
else
    out = in_ext;
end
