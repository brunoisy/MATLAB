function [ x ] = subgradient(A, b, lambda, x0, N, epsilon)
%	subGradient 
% It computes the optimal solution for l1-LS problem
% by subgradient method
%
% min{f(x) = ||Ax-b||^2 + lambda ||x||_1}
%
% INPUT :
%	- A : matrix A from the problem
%	- b : matrix b from the problem
% 	- lambda : parameter lambda from the problem
%	- x0 : initial point
%       - N : Number of iterations
%       - epsilon : accuracy
%
% OUTPUT
%	- x : solution for each iteration

n= length(x0);
G = 2*norm(A'*(A*x0-b))+sqrt(n)*lambda;
alpha = epsilon/(G^2);

x = zeros(n,N+1);
x(:,1) = x0;

for k = 1:N
	g = 2*A'*(A*x(:,k)-b)+sign(x(:,k))*lambda;
	x(:,k+1) = x(:,k)-alpha*g;
end

end