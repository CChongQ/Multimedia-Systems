function out = rev_cdf(in)
% Reverse CDF 9/7 Wavelet Transform
%  (implemented using lifting)
%
% © Karl Martin 2003
% Multimedia Lab,
% University of Toronto

N = length(in);

in_inter(1:2:N) = in(1:ceil(N/2))/sqrt(2);
in_inter(2:2:N) = in((floor(N/2)+1):N)*sqrt(2);

sz = size(in);
if sz(1) > 1
    in = in';
    if sz(2) > 1
        error('Input must be 1 dimensional.');
    end
end

N_odd = mod(N,2);

in_ext = ext_symper(in_inter,3,4-N_odd);

M = length(in_ext);
y_even = in_ext(2:2:M);
L_even = length(y_even);

y_odd = in_ext(1:2:M);
L_odd = length(y_odd);

a = -1.586134342;
b = -0.052980118;
c = 0.882911075;
d = 0.443506852;
K = 1.230174105;

x_even = K*y_even;                                                      % [STEP 1]
x_odd = -(1/K)*y_odd;                                                   % [STEP 2]
x_even = x_even - d*(x_odd(1:(L_odd-1))+x_odd(2:L_odd));                % [STEP 3]
x_odd = x_odd(2:(L_odd-1)) - c*(x_even(1:(L_even-1))+x_even(2:L_even)); % [STEP 4]
L_odd = length(x_odd);
x_even = x_even(2:(L_even-1)) - b*(x_odd(1:(L_odd-1))+x_odd(2:L_odd));  % [STEP 5]
L_even = length(x_even);
x_odd = x_odd(2:(L_odd-1)) - a*(x_even(1:(L_even-1))+x_even(2:L_even)); % [STEP 6]
x_even = x_even(1:(L_even-1+N_odd));

out = zeros(1,N);
out(1:2:N) = x_even;
out(2:2:N) = x_odd;

if sz(1) > 1
    out = out';
end