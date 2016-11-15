function [g, gamma, W] = algorithm1(t, y, alpha, tMax)
% This function returns the value-second derivative representation of the
% natural cubic splines approximating the points (x,y), using Iterative 
% Reweighted Least Squares 

n = length(t)-2;
h = t(2:end) - t(1:end-1);

Q = sparse(n+2,n);
Q(1:n+3:(n+2)*n) = 1./h(1:end-1);
Q(2:n+3:(n+2)*n) = -1./h(1:end-1)-1./h(2:end);
Q(3:n+3:(n+2)*n) = 1./h(1:end-1);

R = sparse(n,n);
R(1:n+1:n*n)   = 1/3*(h(1:end-1)+h(2:end));
R(2:n+1:n*n)   = 1/6*h(2:end-1);
R(n+1:n+1:n*n) = 1/6*h(2:end-1);


W = speye(n+2); % problem with weights
for k = 1:tMax
    gamma = (R + alpha*(Q'*Q))\(Q'*sqrt(W)*y);
    g = y - diag(1./sqrt(diag(W)))*alpha*Q*gamma;
    W = diag(1./abs(y-g));
end

