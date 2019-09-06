function [ W, WXXW,WXGXGWPool ] = UpdateW(P,W, U, V, X, betav, XX,PGr, XGXGPool, MgPool, param )

     
     k = param.k;
     [d,~] = size(X);
 
     manifold = euclideanfactory(d, k);
     problem.M = manifold;
     problem.cost = @(x) Wcost(P,x, U, V, X, betav, XX,PGr, XGXGPool, MgPool, param);
     problem.grad = @(x) Wgrad(P,x, U, V, X, betav, XX,PGr, XGXGPool, MgPool, param);
     checkgradient(problem);
     
     options = param.tooloptions;
     %[x xcost info] = trustregions(problem,W,options);
     [x xcost info] = steepestdescent(problem,W,options);
     W = x;
     WXXW = W'*XX*W;
     WXGXGWPool = cell(size(MgPool));
     for i=1:length(MgPool)
         WXGXGWPool{i} = x'*XGXGPool{i}*x;
     end
end

function cost = Wcost(P,x,U, V, X, betav, XX,PGr, XGXGPool, MgPool, param)
 % cost = 0.5*param.lambda1*norm(V-W'*X,'fro')^2 + 0.5*param.lambda4*norm(W,'fro')^2+0.5*param.lambda5*trace(X'*W*U'*S*U*W'*X);
  lambda = param.lambda;
  lambda1 = param.lambda1;
  lambda2 = param.lambda2;
  lambdaw = param.lambda5;
  
  cost = 0.5*lambda*norm(P.*(x'*X-V),'fro')^2 + 0.5*lambdaw*sum(vecnorm(x'));
%   UWXXWU = U*x'*XX*x*U';
%   for i=1:length(MgPool)
%       Mg = MgPool{i};
%       UWXGXGWU = U*x'*XGXGPool{i}*x*U';
%       cost = cost + lambda2*betav(i)*trace(UWXXWU*Mg) ...
%           + lambda1*trace(UWXGXGWU*Mg);    
%   end
  
  A = U*(P.*(x'*X)); 
%   UPWXXWPU = U*(P.*(x'*X))*(U*(P.*(x'*X)))';
  for i=1:length(MgPool)
      Mg = MgPool{i};
      Ag{i} = (PGr{i}.*(x'*XGXGPool{i,2}));
      cost = cost + lambda2*betav(i)*trace(A*A'*Mg) ...
          + lambda1*trace(U*Ag{i}*Ag{i}'*U'*Mg);    
  end

end

function grad = Wgrad(P,x,U, V, X, betav, XX,PGr, XGXGPool, MgPool, param)
  lambda = param.lambda;
  lambda1 = param.lambda1;
  lambda2 = param.lambda2;
  lambdaw = param.lambda5;
  D=diag(1./(2*vecnorm(x')+eps));
  grad = lambda*X*(P'.*(X'*x - V').*P') + lambdaw*D*x;
  %grad = lambda*XX*x - lambda*X*V' + lambdaw*x;
  A = (P.*(x'*X)); 
  for i=1:length(MgPool)
      Mg = MgPool{i};
      UMU = U'*Mg*U;
      Ag{i} = (PGr{i}.*(x'*XGXGPool{i,2}));
      %grad = grad + (lambda2*betav(i)*XX + lambda1*XGXGPool{i})*x*UMU;
      grad = grad + lambda2*betav(i)*X*(A'*UMU.*P') + lambda1*XGXGPool{i,2}*((Ag{i})'*UMU.*(PGr{i})');
  end
end
