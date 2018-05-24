function [ F ] = fd_multi(deltaLcs, X, lastinliers)

delta = deltaLcs(1);
Lcs = deltaLcs(2:end);

X = X+delta;
F = zeros(1,length(X));

for i = 1:length(Lcs)
    if i==1
        F(1:lastinliers(i)) = fd(Lcs(i), X(1:lastinliers(i)));
    else
        F((lastinliers(i-1)+1):lastinliers(i)) = fd(Lcs(i), X((lastinliers(i-1)+1):lastinliers(i)));
    end
end
end


