function S=Sfun(l,lambda,gamma,n)
    S=1;
    for j=n:-1:1
       if(l(j)<=(lambda-gamma))
          S=j;
          break;
       end
    end
end