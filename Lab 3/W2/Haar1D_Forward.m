function transform = Haar1D_Forward(X)
    N = length(X);
    transform = zeros(N,1);
    for i=1:(N/2)
       %Average
       transform(i) = (X(2*i-1)+X(2*i))/sqrt(2);
       %Difference
       transform(N/2+i) = (X(2*i-1)-X(2*i))/sqrt(2);
    end
end
