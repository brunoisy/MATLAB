function [Lc] = find_par_Lc(mins, x0)
%FIND_LC Summary of this function goes here
%   Detailed explanation goes here
load('constants.mat')

Lc = zeros(1,length(mins));
for i = length(mins):-1:1
    xmin = mins(1,i)-x0;% because we want to find Lc wrt x0
    fmin = mins(2,i);
    for j = (i+1):length(mins)
        fmin = fmin - fd(Lc(j),xmin);
    end
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end

end

