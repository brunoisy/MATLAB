function [inliers, Lc, error] = distfn_2(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

if isempty(x) || isempty(Lc)%usefull??
    'empty x!'
    inliers = [];
    return
end


upbd = 0.7*Lc;

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
inliers = 1:length(Xin);

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

% %%% cut off outliers at start
% for i = 1:length(Xin(Xin<=lobd))
%     if abs(Fin(i)-fd(Lc,Xin(i))) < thresh
%         inliers = inliers(Xin(i) <= Xin);
%         break
%     end
% end
% if i == length(Xin(Xin<=lobd))
%    inliers = inliers(lobd < Xin);
% end


end