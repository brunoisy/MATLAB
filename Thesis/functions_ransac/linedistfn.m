function [inliers, ab] = linedistfn(ab, x, thresh)
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
inliers = inliers(abs(a*X+b) < F+thresh);%to check

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