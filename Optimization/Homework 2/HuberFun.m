function y = HuberFun(x)
%HUBERFUN Summary of this function goes here
%   Detailed explanation goes here

lambda = 1;
mu = 1.5;

if norm(x,1) <= mu 
    y = lambda*norm(x,1)^2/(2*mu);
else
    y = lambda*(norm(x,1)-mu/2);
end

