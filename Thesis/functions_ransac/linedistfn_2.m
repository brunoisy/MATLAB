function [inliers, ab] = linedistfn_2(ab, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

a = ab(1);
b = ab(2);

if isempty(x)
    inliers = [];
    return
end
X = x(1,:);
F = x(2,:);

inliers = 1:length(X);
inliers = inliers(abs(F-(a*X+b))<thresh);


for i = length(inliers):-1:1
    if inliers(i) ~= i-length(inliers)+length(X)
        if i==length(inliers)
            inliers = [];
        else
            inliers = inliers(i+1:length(inliers));
        end
        break
    end
end
end