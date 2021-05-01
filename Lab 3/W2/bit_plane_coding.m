function output = bit_plane_coding(input,N)
    
    %extract the signs of the input
    signs = sign(input);
    %Perform the bit-plane coding on the absolute value of the input
    input = abs(input);
    %b_MSB: MSB of the value being considered
    b_MSB = floor(log2(input));
    
    %first bit-plane
    c_max = max(input(:));
    b_0 = floor(log2(c_max));
    
    %default set to 0:coefficient not significant
    output = zeros(size(input));
    
    for plane = 1:N
        b = b_0 - plane +1; %current bit-plane being coded
      
        bit = mod(floor(input/2^b),2);%extract current bit-plane
        
        %coefficient found significant at current bit-plane
        output(b==b_MSB) = 1.5*2^b;
       
        %coefficient found significant at a previous bit-plane
        sig_prev = b_MSB>b; 
        [n,m,~] = size(bit);
        for i = 1:n
            for j = 1:m
                current_bit = bit(i,j);
                if (sig_prev(i,j) ==1)
                    if (current_bit == 0) % current bit =0, sbstract 0.5*2^b from the previous approximate value
                        output(i,j) = output(i,j) - 0.5*2^b;
                    else % current bit =1, add 0.5*2^b to the previous approximate value
                       output(i,j) = output(i,j) + 0.5*2^b;
                    end
                end
            end
        end
    end

    %put the signs back
    output = output.*signs;
end