function [inliers, Lc, error] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

%thresh should be a parameter not an argument

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
FXin_up = fd(Lc+25,Xin);
stop = 0;
for i = length(Fin):-1:1
   if Fin(i) < FXin_up(i)
       stop = i;
       break
   end
end
if stop == 0
    inliers = [];
else   
    inliers = 1:stop;

    [~, ind] = min(Fin(inliers));
    %%% cut off outliers at end
    for i = ind:length(Xin)
        if Fin(i) > Fin(ind) + thresh 
            inliers = 1:i-1;
            break
        end
    end
end

if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end

end