function out = fwd_cdf(in)
% Forward CDF 9/7 Wavelet Transform
%  (implemented using lifting)
%
% © Karl Martin 2003
% Multimedia Lab,
% University of Toronto

in = double(in);

sz = size(in);
if sz(1) > 1
    in = in';
    if sz(2) > 1
        error('Input must be 1 dimensional.');
    end
end

N = length(in);

N_odd = mod(N,2);

in_ext = ext_symper(in,4,3+N_odd);

M = length(in_ext);
in_even = in_ext(1:2:M);
L_even = length(in_even);

in_odd = in_ext(2:2:M);
L_odd = length(in_odd);

a = -1.586134342;
b = -0.052980118;
c = 0.882911075;
d = 0.443506852;
K = 1.230174105;

y_odd = in_odd + a*(in_even(1:(L_even-1)) + in_even(2:L_even));           % [STEP 1]
y_even = in_even(2:(L_even-1)) + b*(y_odd(1:(L_odd-1))+y_odd(2:L_odd));   % [STEP 2]
L_even = length(y_even);
y_odd = y_odd(2:(L_odd-1)) + c*(y_even(1:(L_even-1)) + y_even(2:L_even)); % [STEP 3]
L_odd = length(y_odd);
y_even = y_even(2:(L_even-1)) + d*(y_odd(1:(L_odd-1)) + y_odd(2:L_odd));  % [STEP 4]
y_odd = -K*y_odd(2:(L_odd-N_odd));      % [STEP 5]
y_even = (1/K)*y_even;                                                    % [STEP 6]

out = [sqrt(2)*y_even y_odd/sqrt(2)];

if sz(1) > 1
    out = out';
end