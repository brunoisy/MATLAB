n = 20;
rng(10);
A0 = orth(randn(n,n));
Aa = rand(n,n);
x0 = ones(n,1);
it = 10000;
shift1 = 1.3;
shift2 = 1 + 0.2i;
[v1, lambda1] = puissance(A0, x0, 1000);
[v2, lambda2] = iteration_inverse(A0, x0, shift1, it);
[v3, lambda3] = iteration_inverse(A0, x0, shift2, it);

[V, D] = eig(Aa);
norm(max(diag(D)))
[v1, lambda1] = puissance(Aa, x0, 10);

% lambdas = eigs(Aa)
% norm(max(lambdas))
%norm(max(eigs(A0)))
