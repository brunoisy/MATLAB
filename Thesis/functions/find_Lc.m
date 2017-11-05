function [Lc] = find_Lc(mins, x0)
%FIND_LC Summary of this function goes here
%   Detailed explanation goes here
kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;

minsize = size(mins);
minlength = minsize(2);
Lc = zeros(1,minlength);
for i = 1:minlength
    xmin = mins(1,i)-x0;% because we want to find Lc wrt x0
    fmin = mins(2,i);
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end

end

