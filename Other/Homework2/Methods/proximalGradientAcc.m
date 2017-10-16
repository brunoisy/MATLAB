function [ x ] = proximalGradientAcc(A, b, lambda, x0, N, epsilon)
%	proximalGradientAcc 
% It computes the optimal solution for l1-LS problem
% by accelerated proximal gradient method
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
L = 2*normest(A'*A);
gradf1 = @(x) 2*A'*(A*x-b);
    function [y] = prox(x)%vectoriser?
        y=zeros(1,length(x));
        for i=1:length(x)
            if x(i) >lambda/L
                y(i) = x(i)-lambda/L;
            elseif abs(x(i)) <= lambda/L;
                y(i) = 0;
            else
                y(i) = x(i)+lambda/L;
            end
        end
    end

x = zeros(n,N+2);
x(:,1) = x0;
x(:,2) = x0;
for k = 2:N+1
    beta = (k-3)/(k);
    y = x(:,k)+beta*(x(:,k)-x(:,k-1));
    x(:,k+1) = prox(y - 1/L*gradf1(y));
end

x = x(:,2:end);

end