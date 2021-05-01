function sad = SAD(T,R,x,y,i,j)
   k = 15;
   l = 15;
   sad = sum(sum(abs(T(x:x+k,y:y+l)-R(x+i:x+i+k,y+j:y+j+l))));

 end
% % function sad = SAD(T,R,x,y,i,j)
% %     sad = 0;
% %     for k = 0:15
% %         for l = 0:15
% %             disp([x+k,y+l])
% %             disp([x+i+k,y+j+l])
% %             sad = sad + abs(T(x+k,y+l)-R(x+i+k,y+j+l));
% %         end
% %     end
% % end


