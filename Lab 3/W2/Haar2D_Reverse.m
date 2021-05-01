function reconstruct = Haar2D_Reverse(X)
    
    reconstruct = X;
    [r,c,~] = size(X);
    
    for row = 1:r
         reconstruct(row,:) = Haar1D_Reverse(reconstruct(row,:));
    end 

    for col = 1:c 
        reconstruct(:,col) = Haar1D_Reverse(reconstruct(:,col));
    end
    
    

end
