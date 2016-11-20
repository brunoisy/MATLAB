lambda = -1;
f1 = @(x1,x2) lambda*x1+4*x2^3;
f2 = @(x1,x2) lambda*x2-4*x1^3; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
% f est une spirale stable

lambda = -1;
f1 = @(x1,x2) lambda*x1+3*x2^2;
f2 = @(x1,x2) lambda*x2; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
f est un noeud stable dégénéré (sur?)

%Remarque : noeud stable et etoile stable très proches (suffit de rajouter terme quadratique !)