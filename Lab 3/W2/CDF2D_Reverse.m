function reconstruct = CDF2D_Reverse(X)
    
    reconstruct = X;
    [r,c,~] = size(X);
    
    for row = 1:r
         reconstruct(row,:) = rev_cdf(reconstruct(row,:));
    end 

    for col = 1:c 
        reconstruct(:,col) = rev_cdf(reconstruct(:,col));
    end
    
end
