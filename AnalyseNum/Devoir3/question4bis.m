n = 1000;
L = diag(2*ones(n,1),0)+ diag(ones(n-1,1),1) + diag(-ones(n-1,1),-1);

iteration = 1000;
x0 = ones(n,1);
shift = 2;
p = 10;

lambda = eig(L);
%[v1,lambda1] = puissance(L,x0,iteration);
%[v2,lambda2] = iteration_inverse(L,x0,shift,iteration);
%[v3,lambda3] = rayleigh(L,x0,iteration);
[v4,lambda4] = rayleighRitzArnoldi(L,p, iteration);