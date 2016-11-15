function [g, gamma] = ncsInterpol(x, y)
% natural cubic spline interpolation
% This function returns the value-second derivative representation of the
% natural cubic splines interpolating the points (x,y)

n = length(x)-2;
h = x(2:end) - x(1:end-1);

Q = zeros(n+2,n);
for i = 2:n+1
    Q(i-1,i-1) = 1/h(i-1);
    Q(i,i-1)   = -1/h(i-1) -1/h(i);
    Q(i+1,i-1) = 1/h(i);
end

R = zeros(n,n);
R(1,1) = 1/3*(h(1)+h(2));
for i=2:n;
    R(i,i)   = 1/3*(h(i)+h(i+1));
    R(i-1,i) = 1/6*h(i);
    R(i,i-1) = 1/6*h(i);
end

g = y(2:end-1);
gamma = R\(Q'*y);
end

