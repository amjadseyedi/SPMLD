function P=updateP(L,lambda,gamma)
[l,n]=size(L);
P=zeros(l,n);
for j=1:l
    [l,iL] = sort(L(j,:)); 
    G=Gfun(l,lambda,n);
    S=Sfun(l,lambda,gamma,n);
    k0=1;
    k1=G;
    p0=pfun(k0,k1,l,lambda);
    q=qfun(k0,k1,l,lambda);
    c=cfun(k0,l,lambda,gamma,p0,q);
    k0=argminK0(n,S,k0,k1,l,lambda,gamma,p0,q,c);
    c=cfun(k0,l,lambda,gamma,p0,q);
    p=updateW2(n,k0,k1,c,lambda,l);
    P(j,(iL))=p';
end
end