function G=Gfun(l,lambda,n)
    G=n;
    for j=1:n
       if(l(j)>=lambda)
          G=j;
          break;
       end
    end
end