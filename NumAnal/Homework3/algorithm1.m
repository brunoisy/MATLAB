function [g, gamma, W] = algorithm1(t, y, alpha, tMax)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = length(t)-2;
h = t(2:end) - t(1:end-1);% length = m

Q = sparse(n+2,n);
for i = 2:n+1 % problem indexation des h P6 addenda (i->i-1) A VERIFIER!
    Q(i-1,i-1) = 1/h(i-1);
    Q(i,i-1)   = -1/h(i-1) -1/h(i);
    Q(i+1,i-1) = 1/h(i);
end

R = sparse(n,n);
R(1,1) = 1/3*(h(1)+h(2));
for i=2:n;
    R(i,i)   = 1/3*(h(i)+h(i+1));
    R(i-1,i) = 1/6*h(i);
    R(i,i-1) = 1/6*h(i);
end


W = speye(n+2); % problem with weights
for k = 1:tMax
    gamma = (R + alpha*(Q'*Q))\(Q'*sqrt(W)*y);
    g = y - inv(sqrt(W))*alpha*Q*gamma;
    W = diag(1./abs(y-g));
end

