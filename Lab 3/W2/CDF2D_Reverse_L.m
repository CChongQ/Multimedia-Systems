function reconstruct = CDF2D_Reverse_L(X,L)
    reconstruct = X;
    [r,c,~] = size(X);
    for level = L:-1:1
        block = reconstruct(1:r/2^(level-1),1:c/2^(level-1));
        reconstruct(1:r/2^(level-1),1:c/2^(level-1)) = CDF2D_Reverse(block);
    end

end


