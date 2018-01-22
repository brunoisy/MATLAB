function [inliers, Lc, error] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

%thresh should be a parameter not an argument

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
FXin = fd(Lc, Xin);
FXin_up = fd(Lc+25,Xin);

inliers= 1:length(Xin);
[~, ind] = min(Fin(Fin<FXin_up));
%might be problematic if we loose some first points (bad indexing)



%%% cut off outliers at end
for i = ind:length(Xin)
    if Fin(i) > Fin(ind) + thresh %Fin(i)-fd(Lc,Xin(i)) > thresh
        inliers = 1:i-1;
        break
    end
end
[~, ind] = min(Fin(inliers));
inliers = 1:ind;

% for i = length(inliers):-1:ind+1
%    if Fin(i-1) > Fin(i)
%       inliers = 1:i;
%       break
%    end
% end


if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end


% start = length(Xin);
% FXin_low = fd(Lc-4,Xin);
% for i = 1:length(Xin)
%     if Fin(i) > FXin_low(i)-thresh
%         start = i;
%         break
%     end
% end
% stop = 1;
% FXin_up = fd(Lc+4,Xin);
% for i = length(Xin):-1:1
%     if Fin(i) < FXin_up(i)+thresh
%         stop = i;
%         break
%     end
% end
% inliers = start:stop;





% inliers= 1:length(Xin);
% [~, ind] = min(Fin(Fin-FXin<50));%50?????
% %might be problematic if we loose some first points (bad indexing)
% 
% 
% %%% cut off outliers at end
% for i = ind:length(Xin)
%     if Fin(i)-Fin(ind) > thresh %Fin(i)-fd(Lc,Xin(i)) > thresh
%         inliers = 1:i-1;
%         break
%     end
% end
% 
% 
% if isempty(inliers)
%     error = Inf;
% else
%     error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
% end

end