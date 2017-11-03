function [inliers, Lc] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

X = x(1,:);
F = x(2,:);
x1 = 10*10^-9;% arbitrary!
admissX = X(x1<X & X<Lc);
admissF = F(x1<X & X<Lc);
admissX = admissX(abs(admissF-fd(Lc, admissX))<thresh);% add if isempty(admissX)... for robustness? (problem when 2 Lc curves collapse)

if(isempty(admissX))
    inliers = zeros(1,length(X));
else
    Xfirst = admissX(1);
    Xlast = admissX(end);
    inliers = x(:,Xfirst<=X & X<Xlast);
end


end