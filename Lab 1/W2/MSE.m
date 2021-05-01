function mse = MSE(P,Q)
    P = double(P);
    Q = double(Q);
    norm = ((P(:,:,1)-Q(:,:,1)).^2 + (P(:,:,2)-Q(:,:,2)).^2 + (P(:,:,3)-Q(:,:,3)).^2) / 3;
    [x,y,~] = size(P);
    n = x*y;
    mse = sum(norm,'all')/n;   
end