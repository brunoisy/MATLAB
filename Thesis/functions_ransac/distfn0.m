function [inliers, Lc, error] = distfn0(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

%thresh should be a parameter not an argument

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);

inliers= 1:length(Xin);

if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end

end