function [ F ] = fd_curve(Lc, X)
%FD_CURVE Summary of this function goes here
%   Detailed explanation goes here

global C

Fx = @(x) -C*(1/(4*(1-x/Lc)^2)-1/4+x/Lc);
F = zeros(1,length(X));
for i = 1:length(X)
    F(i) = Fx(X(i));
end


end

