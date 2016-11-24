function [g, gamma] = ncsInterpol(x, y)
% natural cubic spline interpolation
% This function returns the value-second derivative representation of the
% natural cubic splines interpolating the points (x,y)

n = length(x)-2;
h = x(2:end) - x(1:end-1);

Q = sparse(n+2,n);
Q(1:n+3:(n+2)*n) = 1./h(1:end-1);
Q(2:n+3:(n+2)*n) = -1./h(1:end-1)-1./h(2:end);
Q(3:n+3:(n+2)*n) = 1./h(1:end-1);

R = sparse(n,n);
R(1:n+1:n*n)   = 1/3*(h(1:end-1)+h(2:end));
R(2:n+1:n*n)   = 1/6*h(2:end-1);
R(n+1:n+1:n*n) = 1/6*h(2:end-1);

g = y(2:end-1);
gamma = R\(Q'*y);
end