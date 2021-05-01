function reconstruct = Haar1D_Reverse(X)
    N = length(X);
    reconstruct = zeros(N,1);
    
    for i=1:(N/2)
       reconstruct(2*i-1)= (X(i) + X(N/2+i))/sqrt(2);
       reconstruct(2*i)= (X(i) - X(N/2+i))/sqrt(2);
    end

    
end

