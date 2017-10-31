function [Lc] = find_Lc(mins, x0)
%FIND_LC Summary of this function goes here
%   Detailed explanation goes here
global C

Lc = zeros(1,length(mins));
for i = 1:length(mins)
    xmin = mins(1,i)-x0;% because we want to find Lc wrt x0
    fmin = mins(2,i);
    
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end

end

