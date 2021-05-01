%%1.2 forward transform
G_a = 3*ones(8);
G_b = 10*ones(8);
G_b(:,1:2:end) = 5;
[T_a,T_b,T_a_int,T_b_int] = deal(zeros(8));

for u = 0:1
    for v = 0:1
       G_a_block = G_a(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       G_b_block = G_b(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       %Case(a)
       a_f_temp = Forward_DCT(G_a_block);
       a_f_int_temp = Forward_DCT_H264(G_a_block);
       T_a(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = a_f_temp;
       T_a_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = a_f_int_temp;
       %Case(b)
       b_f_temp = Forward_DCT(G_b_block);
       b_f_int_temp = Forward_DCT_H264(G_b_block);
       T_b(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = b_f_temp;
       T_b_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = b_f_int_temp;
    end
end



%%1.3 
%DCT operation
G_a_norm = norm(G_a,2);
G_b_norm = norm(G_b,2);
T_a_norm = norm(T_a,2);
T_b_norm = norm(T_b,2);
T_a_norm_difference = abs(G_a_norm - T_a_norm);
T_b_norm_difference = abs(G_b_norm - T_b_norm);
%integer transform
T_a_int_n = norm(T_a_int,2);
T_b_int_n = norm(T_b_int,2);
T_a_int_norm_difference = abs(G_a_norm - T_a_int_n);
T_b_int_norm_difference = abs(G_b_norm - T_b_int_n);



%%1.4 backward transform
%DCT operation
[G_a_back,G_b_back] = deal(zeros(8));
for u = 0:1
    for v = 0:1
       T_a_block = T_a(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       T_b_block = T_b(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       %Case(a)
       a_back_temp = Backward_DCT(T_a_block);
       G_a_back(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = a_back_temp;
       %Case(b)
       b_back_temp = Backward_DCT(T_b_block);
       G_b_back(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = b_back_temp;
    end
end
%integer transform
[G_a_int,G_b_int] = deal(zeros(8));
for u = 0:1
    for v = 0:1
       T_a_block = T_a_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       T_b_block = T_b_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4);
       
       a_back_int_temp = Backward_DCT_H264(T_a_block);
       G_a_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = a_back_int_temp;
       
       b_back_int_temp = Backward_DCT_H264(T_b_block);
       G_b_int(4*u+1:(u+1)*4,4*v+1:(v+1)*4) = b_back_int_temp;
    end
end



%%1.5
N = 6;
F = DCT_F(N);
Fmax = max(F,[],'all');
Fmin = min(F,[],'all');
clims = [Fmin Fmax];
count = 1;
for u = 1:N
    for v = 1:N   
        subplot(N,N,count);
        I_uv = F(u,:)'*F(v,:);%basis image
        imagesc(I_uv,clims);
        count = count + 1;
    end
end
colormap('gray');


