function [ X ] = fd_inv(Lc, F)
% UNTESTED!

kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
C  = kb*T/lp;

%F = -kb*T/lp*(1./(4*(1-X./Lc).^2)-1/4+X./Lc);

A = 4*F/C;
p = [4, -Lc*(9-A), 2*Lc^2*(3-A), A*Lc^3];%[A*Lc^3, 2*Lc^2*(3-A), -Lc*(9-A), 4];
thisroots = roots(p);
thisroots = thisroots(thisroots>0);
X = real(thisroots(1));

end