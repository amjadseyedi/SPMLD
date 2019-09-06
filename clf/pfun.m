function p=pfun(k0,k1,l,lambda)
    p=sum((lambda-l(k0+1:k1-1)).^2);
end