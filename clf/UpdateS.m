function [ L,S] = UpdateS(Ag,A,W,L,betag,UWXXWU,UWXGXGWU,param)
   [l,k] = size(L);
  
   manifold = elliptopefactory(l,k);
   problem.M = manifold;
    
    % Define the problem cost function and its gradient.
    problem.cost = @(x) LCost(Ag,A,W,x, betag, UWXXWU,UWXGXGWU,param);
    problem.grad = @(x) LGrad(Ag,A,W,x, betag, UWXXWU,UWXGXGWU,param);

    % Numerically check gradient consistency.
%     checkgradient(problem);

    options = param.tooloptions;
   % [x xcost info] = trustregions(problem,L,options);
     [x xcost info] = steepestdescent(problem,L,options);
    L = x;
    S = L*L';
%    USU = U'*S*U;
end

function cost = LCost(Ag,A,W,L,betag, UWXXWU,UWXGXGWU,param)
    lambda1=param.lambda1;
    lambda2=param.lambda2;
    cost = 0.5*lambda2*betag*trace(A*A'*L*L')+0.5*lambda1*trace(Ag*Ag'*L*L');
end
function grad = LGrad(Ag,A,W,L,betag, UWXXWU,UWXGXGWU,param)
    lambda1=param.lambda1;
    lambda2=param.lambda2;
    
    grad = lambda2*betag*A*A'*L+lambda1*Ag*Ag'*L;
end