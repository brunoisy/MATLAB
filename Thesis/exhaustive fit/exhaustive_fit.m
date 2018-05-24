function [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist, force)
%EXHAUSTIVE_FIT_FD Summary of this function goes here
%   Detailed explanation goes here

maxn = 20;
mininliers = 10;
margin = 1.5;
thresh = 7;

Lcs = zeros(1,maxn);
firstinliers = zeros(1,maxn);
lastinliers = zeros(1,maxn);

lo = 0;
hi = 60;
prevlastinlier = 0;

i = 1;
while(i<maxn)
    bestLc = 0;
    besterror = Inf;
    bestinliers = [];
    if i==1
        testLcs = dist(1)+(lo:0.5:hi);
    else
        testLcs = Lcs(i-1)+(lo:0.5:hi);
    end
    
    for testLc = testLcs
        Xin = dist(prevlastinlier+1:end);
        Fin = force(prevlastinlier+1:end);
        inPeak = (Fin-thresh) < fd(testLc+margin, Xin);%!!
        inliers = prevlastinlier+(1:find(inPeak,1,'last'));
        if isempty(inliers)
            error = Inf;
        else
            error = mean((force(inliers)-fd(testLc, dist(inliers))).^2);
        end
        if error < besterror
            bestLc = testLc;
            besterror = error;
            bestinliers = inliers;
        end
    end
    if ~isempty(bestinliers)
        if length(bestinliers) < mininliers
            prevlastinlier = bestinliers(end);
            if lastinliers(i) == length(dist)
                Lcs = Lcs(1:i);
                firstinliers = firstinliers(1:i);
                lastinliers = lastinliers(1:i);
                break
            end
            i = i-1;
        else
            Lcs(i) = bestLc;
            firstinliers(i) = bestinliers(1);
            lastinliers(i) = bestinliers(end);
            prevlastinlier = lastinliers(i);
            if lastinliers(i) == length(dist)
                Lcs = Lcs(1:i);
                firstinliers = firstinliers(1:i);
                lastinliers = lastinliers(1:i);
                break
            end
        end
    else
        Lcs = Lcs(1:i-1);
        firstinliers = firstinliers(1:i-1);
        lastinliers = lastinliers(1:i-1);
        break
    end
    i = i+1;
end
