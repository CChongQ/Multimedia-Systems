function F = DCT_F(N)
    F = zeros(N,N);
    for i = 0:N-1
        for j = 0:N-1
             if i==0
                F(i+1,j+1) = sqrt(1/N) * cos((2*j+1)*i*pi/(2*N));
            else
                F(i+1,j+1) = sqrt(2/N) * cos((2*j+1)*i*pi/(2*N));
            end
        end
    end 
end