function [ x ] = smoothedGradient(A, b, lambda, x0, N, epsilon)
%	smoothedGradient 
% It computes the optimal solution for l1-LS problem
% by smoothed gradient method
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

n = length(x0);
%mu = epsilon/(lambda*n)
mu = (-lambda*n+sqrt(lambda^2*n^2+4*n*normest(A'*A)*epsilon))/(2*normest(A'*A)*n);
L = 2*normest(A'*A)+lambda/mu;

%normX0MinusXOptimal = 5.4903;
%N = ceil(L*normX0MinusXOptimal^2/(2*(epsilon-lambda*n*mu)));

h = 1/L;
gradF = makeGradSmoothedF(A, b, mu, lambda);
x = zeros(n,N+1);
x(:,1) = x0;
for i = 1:N
    x(:,i+1) = x(:,i) - h*gradF(x(:,i));
end

end