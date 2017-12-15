function [inliers, Lc, error] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

%thresh should be a parameter not an argument

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
inliers = 1:length(Xin);


FXin = fd(Lc, Xin);
[~, ind] = min(Fin(Fin-FXin<50));
%might be problematic if we loose some first points (bad indexing)


%%% cut off outliers at end
for i = ind:length(Xin)
    if Fin(i)-Fin(ind) > thresh %Fin(i)-fd(Lc,Xin(i)) > thresh
        inliers = 1:i-1;
        break
    end
end


if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end

end