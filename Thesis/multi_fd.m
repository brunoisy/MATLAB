function [ F ] = multi_fd(x0Lc, X)
%MULTI_FD Summary of this function goes here
%   Detailed explanation goes here
x0 = x0Lc(1);
Lc = x0Lc(2:end);

X = X-x0;
F = zeros(1,length(X));

for i = 1:length(Lc)
    if i==1
        F(X<Lc(i)) = fd(Lc(i), X(X<Lc(i)));
    else
        F(Lc(i-1)<X & X<Lc(i)) = fd(Lc(i), X(Lc(i-1)<X & X<Lc(i)));
    end
end
end

