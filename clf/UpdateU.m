function [ U ] = UpdateU(P,U, J, Y, V, betav,MgPool, W, X, XGXGPool, WXXW,WXGXGWPool, param, PGr )

     
     k = param.k;
     [l,~] = size(Y);
 
     manifold = euclideanfactory(l, k);
     problem.M = manifold;
     problem.cost = @(x) Ucost(P,x,J,Y,V,betav,MgPool,W, X, PGr, XGXGPool, WXXW,WXGXGWPool,param);
     problem.grad = @(x) Ugrad(P,x,J,Y,V,betav,MgPool,W, X, PGr, XGXGPool, WXXW,WXGXGWPool,param);
 %    problem.finalproj = @(x) Uproj(x);
   checkgradient(problem);
 
     options = param.tooloptions;
     %[x xcost info] = trustregions(problem,U,options);
     [x xcost info] = steepestdescent(problem,U,options);
    % [x xcost info] = conjugategradient(problem,U,options);
     U = x;

end
function proj = Uproj(U)
   U(U<0) = 0;
   proj = U;
end
function cost = Ucost(P,x,J,Y,V,betav,MgPool,W,X,PGr,XGXGPool,WXXW,WXGXGWPool,param)

  lambdau = param.lambda4;
  lambda1 = param.lambda1;
  lambda2 = param.lambda2;
  cost = 0.5*norm(J.*(x*V-Y),'fro')^2 + 0.5*lambdau*norm(x,'fro')^2;
  A = x*(P.*(W'*X)); 
  for i=1:length(MgPool)
      Mg = MgPool{i};
      Ag{i} = (PGr{i}.*(W'*XGXGPool{i,2}));
      cost = cost + lambda2*betav(i)*trace(A*A'*Mg) ...
          + lambda1*trace(x*Ag{i}*Ag{i}'*x'*Mg);    
  end
end
function grad = Ugrad(P,x,J,Y,V,betav,MgPool,W,X,PGr,XGXGPool,WXXW,WXGXGWPool,param)
  
  lambdau = param.lambda4;
  lambda1 = param.lambda1;
  lambda2 = param.lambda2;
  grad = (J.*(x*V-Y).*J)*V' + lambdau*x;
    A = (P.*(W'*X));
  for i=1:length(MgPool)
      Mg = MgPool{i};  
      Ag{i} = (PGr{i}.*(W'*XGXGPool{i,2}));
      grad = grad + Mg*x*(lambda2*betav(i)*A*A' + lambda1*Ag{i}*Ag{i}');
  end
end
