function G = Reconstruct(T_y,T_Cb,T_Cr,Q_y,Q_CbCr,dim)
    for u = 0:(dim/8-1)
        for v = 0: (dim/8-1)
           T_y_block = T_y(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
           T_Cb_block = T_Cb(8*u+1:(u+1)*8,8*v+1:(v+1)*8);
           T_Cr_block = T_Cr(8*u+1:(u+1)*8,8*v+1:(v+1)*8);

           G(8*u+1:(u+1)*8,8*v+1:(v+1)*8,1) = Backward_DCT(T_y_block.*Q_y);
           G(8*u+1:(u+1)*8,8*v+1:(v+1)*8,2) = Backward_DCT(T_Cb_block.*Q_CbCr);
           G(8*u+1:(u+1)*8,8*v+1:(v+1)*8,3) = Backward_DCT(T_Cr_block.*Q_CbCr);
        end
    end
end