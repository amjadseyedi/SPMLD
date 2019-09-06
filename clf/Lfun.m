function L=Lfun(k0,k1,l,lambda,gamma,p,q,c)
    L=sum(l(1:k0))-lambda*(k0+c*q)+gamma*(sqrt(k0+p*(c^2)));
end