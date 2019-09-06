function c=cfun(k0,l,lambda,gamma,p,q)
    if(gamma^2~=p)
        c=real(sqrt(k0/(gamma^2-p)));
    elseif(gamma^2==p && gamma^2<q)
        c=1/(lambda-l(k0+1));
    elseif(gamma^2==p && gamma^2>=q)
        c=0;
    end    
end