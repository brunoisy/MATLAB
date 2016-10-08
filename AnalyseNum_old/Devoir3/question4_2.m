n = 1000;
x = 2*ones(n,1);
y = -ones(n-1,1);
L = diag(x) + diag(y, 1) + diag(y, -1);

[V0, D0] = eig(L);
[V1, D1] = rayleighRitzLanczos(L, 10, 1);


 [~, pos] = max(diag(D0));
 dirprinc = (V0(:, pos))';

 [~, pos] = max(D1);
 dirprincappr = (V1(:, pos))';  