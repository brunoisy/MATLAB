function [Lcs, firstinliers, lastinliers, delta] = exhaustive_free_offset(dist, force)
%WITH_FREE_OFFSET Summary of this function goes here
%   Detailed explanation goes here

delta = 0;

for k= 1:3%:1:3
    [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist+delta, force);
    Xsel = [];
    Fsel = [];
    lastselinliers = zeros(1,length(lastinliers));
    for j = 1:length(firstinliers)
        Xsel = [Xsel, dist(firstinliers(j):lastinliers(j))];
        Fsel = [Fsel, force(firstinliers(j):lastinliers(j))];
        if j ==1
            lastselinliers(j) = lastinliers(j)-firstinliers(j)+1;
        else
            lastselinliers(j) = lastselinliers(j-1)+1+lastinliers(j)-firstinliers(j);
        end
    end
%     Xlast = dist(lastinliers);
    
    length(Xsel)
    
    deltaLcs = lsqcurvefit(@(deltaLcs,x) fd_multi(deltaLcs,x,lastselinliers), [delta, Lcs], Xsel, Fsel);
    delta = deltaLcs(1);
    Lcs = deltaLcs(2:end);
    
end
end

