function PGr = PGroup( P,T )
    
     gp = unique(T);
     g = length(gp);
     
     for i=1:g
       ii = T==gp(i);
       PGr {i} = P(:,ii);
     end   
end