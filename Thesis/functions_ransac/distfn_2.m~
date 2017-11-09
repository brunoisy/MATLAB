function [inliers, Lc] = distfn_2(Lc, x, thresh)
%DISTFN Summary of this function goes here
%   Detailed explanation goes here

if isempty(x)
    print('empty x!')
    inliers = [];
    return
end
X = x(1,:);
F = x(2,:);

% Xadmiss = X(X < Lc);
% Fadmiss = F(F < Lc);
%
% %%% we need to enforce some measure of temporal consistency!
% approx_error = abs(Fadmiss-fd(Lc, Xadmiss));
% inliers = zeros(1, length(Xadmiss));
% j = 0;
% for i = 1:length(Xadmiss)
%     if (approx_error(i) < thresh)
% end
% inliers = inliers(1,1:j);


error = abs(F-fd(Lc, X));
inliers = 1:length(X);
inliers = inliers(X < Lc & error < thresh);%inliers(X < Lc & F < fd(Lc, X)+thresh);%

% We enforce temporal consistency %take longest interval instead of first?
% ??
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
    if(error(inliers(i))< thresh/3)
        inliers = inliers(start:end);
        break
    else
        start = start+1;
    end
end

stop = length(inliers);
for i = length(inliers):-1:i
    if(error(inliers(i))< thresh/3)
        inliers = inliers(1:stop);
        break
    else
        stop = stop-1;
    end
end



% % We enforce temporal consistency, and apply more stringent test at start to avoid taking in outliers
% in_start = 1;
% start = 1;
% stop = length(inliers);
% for i = 1:length(inliers)
%     if in_start
%         if(abs(F(inliers(i))-fd(Lc,X(inliers(i)))) < thresh/2)
%             in_start = 0;
%         else
%             start = start+1;
%         end
%     end
%     if inliers(i) ~= inliers(1)-1+i
%         stop = i-1;
%         break
%     end
% end
inliers = inliers(start:stop);


end