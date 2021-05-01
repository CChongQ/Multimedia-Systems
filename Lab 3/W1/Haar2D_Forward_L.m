function transform = Haar2D_Forward_L(X,L)

    [r,c,~] = size(X);
    LL_subband = X;
    transform = X;
    for level = 1:L
        transform(1:r/2^(level-1),1:c/2^(level-1)) = Haar2D_Forward(LL_subband);
        LL_subband = transform(1:r/(2^level),1:c/2^level);
    end
    
end

