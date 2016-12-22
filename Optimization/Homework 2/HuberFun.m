function y = HuberFun(X)
%HUBERFUN Summary of this function goes here
%   Detailed explanation goes here

lambda = 1;
mu = 5;

function y2 = HuberFun1D(x)
    if x <= mu 
    y2 = lambda*x^2/(2*mu);   
    else
    y2 = lambda*(abs(x)-mu/2);
    end
end

y = 0;
for x = X'
    y = y + HuberFun1D(x);
end

end