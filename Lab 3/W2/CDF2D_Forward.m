function transform = CDF2D_Forward(X)
    transform = X;
    [r,c,~] = size(X);
    
    % perform the 1-level transform on all the rows
    for row = 1:r
         transform(row,:) = fwd_cdf(transform(row,:));
    end 
    %perform the 1-level transform on all the columns 
    for col = 1:c 
        transform(:,col) = fwd_cdf(transform(:,col));
    end

end

