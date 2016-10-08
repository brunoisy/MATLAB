n = 20;
rng(10);
A0 = orth(randn(n,n));
Aa = rand(n,n);

[V0, D0] = eig(A0);
[V1, D1] = rayleighRitzArnoldi(A0, 20, 1);


[V2, D2] = eig(Aa);
[V3, D3] = rayleighRitzArnoldi(Aa, 10, 1);

[~, pos] = max(diag(D2));
dirprinc = (V2(:, pos))';

[~, pos] = max(D3);
dirprincappr = (V3(:, pos))';