function [ x, objs] = interiorPoint(A, b, lambda)
%	InteriorPoint 
% It computes the optimal solution for l1-LS problem
% thanks to SEDUMI
%
% min{f(x) = ||Ax-b||^2 + lambda ||x||_1}
%
% INPUT :
%	- A : matrix A from the problem
%	- b : matrix b from the problem
% 	- lambda : parameter lambda from the problem
% OUTPUT
%	- x : optimal solution
% 	- objs : value of objective function 
%		 at each iterations

[m,n] = size(A);
Atilde = [zeros(m,n),          A, zeros(m,n), zeros(m,n), zeros(m,1), zeros(m,1),  -eye(m,m);
	  zeros(1,n), zeros(1,n), zeros(1,n), zeros(1,n),          1,          0, zeros(1,m);
	   -eye(n,n),  -eye(n,n),   eye(n,n), zeros(n,n), zeros(n,1), zeros(n,1), zeros(n,m);
	    eye(n,n),  -eye(n,n), zeros(n,n),  -eye(n,n), zeros(n,1), zeros(n,1), zeros(n,m)];
btilde = [b; 1/2; zeros(n,1); zeros(n,1)];
ctilde = [lambda*ones(1,n), zeros(1,n), zeros(1,n), zeros(1,n), 0, 1, zeros(1,m)];

K.f = 2*n;
K.l = 2*n;
K.r = m+2;
[x,y,info, objs]=sedumi_objs(Atilde, btilde, ctilde, K);

x = x(n+1:2*n);
 
end