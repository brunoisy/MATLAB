function [inliers, Lc, error] = distfn2(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

%thresh should be a parameter not an argument

X = x(1,:);
F = x(2,:);
Xin = X(X < Lc);
Fin = F(X < Lc);
FXin_up = fd(Lc+25,Xin);

for i = length(Fin):-1:1
   if Fin(i) < FXin_up(i)
       stop = i;
       break
   end
end
inliers = 1:stop;


if isempty(inliers)
    error = Inf;
else
    error = mean((F(inliers)-fd(Lc, X(inliers))).^2);
end

end