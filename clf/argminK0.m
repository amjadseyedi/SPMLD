function k0=argminK0(n,S,k0,k1,l,lambda,gamma,p,q,c)
    L=zeros(n,1);
    for k=S:k1-1
       L(k)=Lfun(k,k1,l,lambda,gamma,p,q,c);
    end
    [~,k0]=min(L);
end