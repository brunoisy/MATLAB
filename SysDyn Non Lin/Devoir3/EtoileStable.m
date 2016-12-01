lambda = -1;
f1 = @(x1,x2) lambda*x1+(sign(x2)+1)*x2^2;
f2 = @(x1,x2) lambda*x2; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
% f est un noeud stable


f1 = @(x1,x2) -x1-x2/log(sqrt(x1^2+x2^2));
f2 = @(x1,x2) -x2+x1/log(sqrt(x1^2+x2^2));
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
% f est une spirale


lambda = -1;
f1 = @(x1,x2) lambda*x1+3*x2^2;
f2 = @(x1,x2) lambda*x2; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
%f est un noeud stable dégénéré