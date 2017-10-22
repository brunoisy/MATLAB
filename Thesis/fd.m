function [ F ] = fd(Lc, x)
%FD Summary of this function goes here
%   Detailed explanation goes here

kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
F = -kb*T/lp*(1./(4*(1-x./Lc).^2)-1/4+x./Lc);

end

