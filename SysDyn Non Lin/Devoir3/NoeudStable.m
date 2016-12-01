f1 = @(x1,x2) -x1+x2^2;
f2 = @(x1,x2) -2*x2+x1^2; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,15,-.5,.5,15)
% f est une noeud stable dégénéré