n = 1000;
x = 2*ones(n,1);
y = -ones(n-1,1);
L = diag(x) + diag(y, 1) + diag(y, -1);
L = sparse(L);
x0 = ones(n,1);
x0 = x0/norm(x0);

%%%%%%%%%%%%%%%%%%%%%%%%%

A=eig(L);
D0 = max(eig(L));
[~, D1] = puissance(L, x0, 100);
[~, D2] = iteration_inverse(L, x0, 5, 100); 
[~, D3] = rayleigh(L, x0, 100); %choix x0?
[~, Ds4] = rayleighRitzArnoldi(L, 10, 1);
D4 = max(Ds4);
[~, Ds5] = rayleighRitzLanczos(L, 10, 1);
D5 = max(Ds5);

%plop = [D0; D1; D2; D3; D4; D5]
