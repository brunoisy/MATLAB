lambda = -1;
b = 0.5;
f1 = @(x1,x2) lambda*x1 + b*x2 + 4*x2^3;
f2 = @(x1,x2) lambda*x2 - 4*x1^3; % f = [f1; f2]
plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
% f est une spirale stable? noeud stable? sur (attention si zoom)

% lambda = -1;
% b = 0.5;
% f1 = @(x1,x2) lambda*x1 + b*x2;
% f2 = @(x1,x2) lambda*x2 + x1^3; % f = [f1; f2]
% plotChamp(f1,f2,-.5,.5,20,-.5,.5,20)
% % f est une spirale stable? noeud stable?