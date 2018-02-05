function [inliers, Lc, error] = distfn_inv(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here



X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
inliers = 1:length(Xin);
[~, ind] = min(Fin);
upbd = X(ind);%min(X(ind), 0.8*Lc);%

%%% cut off outliers at end
for i = max(length(Xin(Xin<=upbd)),1):length(Xin)
    if abs(Xin(i)-fd_inv(Lc,Fin(i))) > thresh
        inliers = inliers(Xin < Xin(i));
        break
    end
end
% %%% cut off outliers at end
% for i = max(length(Xin(Xin<=upbd)),1):(length(Xin)-3)
%     if Fin(i) < Fin(ind)-thresh
%         inliers = inliers(Xin < Xin(i));
%         break
%     end
% end

if isempty(inliers)
    error = Inf;
else
    error = mean((X(inliers)-fd_inv(Lc, F(inliers))).^2);
end

end