function q=qfun(k0,k1,l,lambda)
    q=sum(lambda-l(k0+1:k1-1));
end