function [inliers, Lc] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

thresh = thresh(1);

X = x(1,:);
F = x(2,:);

inliers = 1:length(X);
inliers = inliers(X < Lc & abs(F-fd(Lc, X)) < thresh);

for i = 1:length(inliers)
    if inliers(i) ~= i
        if i==1
            inliers = [];
        else
            inliers = inliers(1:i-1);
        end
        break
    end
end
end