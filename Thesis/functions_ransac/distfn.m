function [inliers, Lc, error] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here



X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
inliers = 1:length(Xin);
[~, ind] = min(Fin);
upbd = min(X(ind), 0.8*Lc);%X(ind)

%%% cut off outliers at end
for i = max(length(Xin(Xin<=upbd)),1):length(Xin)
    if Fin(i)-fd(Lc,Xin(i)) > thresh
        inliers = inliers(Xin < Xin(i));
        break
    end
end
if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end

end