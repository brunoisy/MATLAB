function [inliers, Lc] = distfn(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

if isempty(x) || isempty(Lc)
    'empty x!'
    inliers = [];
    return
end
X = x(1,:);
F = x(2,:);


error = abs(F-fd(Lc, X));
inliers = 1:length(X);
inliers = inliers(X < Lc & error < thresh);

% We enforce temporal consistency 
for i = 1:length(inliers)
    if inliers(i) ~= inliers(1)-1+i
        inliers = inliers(1:i-1);
        break
    end
end


% We remove outliers from limits of inlier interval by applying more
% stringent test
start = 1;
for i = 1:length(inliers)
    if(error(inliers(i)) < thresh/5)
        inliers = inliers(start:end);
        break
    else
        start = start+1;
    end
end

stop = length(inliers);
for i = length(inliers):-1:i
    if(error(inliers(i))< thresh/5)
        inliers = inliers(1:stop);
        break
    else
        stop = stop-1;
    end
end

% We impose the last point to be lower than the first
if ~isempty(inliers) && F(inliers(1)) < F(inliers(end))
    inliers = [];
end

end