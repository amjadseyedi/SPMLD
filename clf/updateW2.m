function W=updateW(n,k0,k1,c,lambda,l)
    W=zeros(n,1);  
    W(1:k0)=1;
    %W(k0+1:k1-1)=0;
    W(k0+1:k1-1)=c*(lambda-l(k0+1:k1-1));    
%     for j=1:n
%         if(j<=k0)
%            W(j)=1;
%         elseif(j>=k1)
%             W(j)=0;
%         else
%             W(j)=c*(lambda-l(j));
%         end
%     end
end