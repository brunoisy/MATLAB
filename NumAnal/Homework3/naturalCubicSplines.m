function [sigma] = naturalCubicSplines(x, y)
% This function returns sigma, the values of the second derivatives of the
% natural cubic splines at interpolation points (x,y). It supposes that the
% x are equidistant

h = x(2)-x(1);
n = length(x)-2;

A = sparse(n+2,n+2);
A(1,1) = 1;
A((n+2)^2) = 1;
A(2:n+3:(n+2)^2-(n+3)) = h;
A(n+4:n+3:(n+2)^2-(n+3)) = 4*h;
A(2*n+6:n+3:(n+2)^2) = h;

b = zeros(n+2,1);
b(1) = 0;
b(n+2) = 0;
b(2:(n+1)) = 6*((y(3:end)-y(2:end-1))/h - (y(2:end-1)-y(1:end-2))/h);

sigma = A\b;
end

