wn = 20;
rng(10);
A0 = orth(randn(n,n));
Aa = rand(n,n);
x0 = ones(n,1);
x = x0/norm(x0);

iteration = 1000;
%As  = A0 + A0';
Asa = Aa + Aa';
%shiftAs = -2.001;
shiftAsa = 12;
%[v4, lambda4] = iteration_inverse(As,x,shiftAs,iteration);
[v5, lambda5] = iteration_inverse(Asa,x,shiftAsa,iteration);
%[v6, lambda6] = rayleigh(As,x,iteration);
%[v7, lambda7] = rayleigh(Asa,x,iteration);

[V,D] = eig(Asa);


[~,pos] = max(diag(D));
dominant = V(:,pos);
[dominant, v5]