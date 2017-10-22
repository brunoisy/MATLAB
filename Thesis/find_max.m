function [ maxs] = find_max( dist, force, maxmax)
%FIND_MAX Summary of this function goes here
%   Detailed explanation goes here

nmax = 0;% # of maximas found
maxs = zeros(2, maxmax);
hi = 30;% size of half comparison interval...
for i=1+hi:length(force)-hi
    if ( (force(i) > max([force(i-hi:i-1),force(i+1:i+hi)])))
        nmax = nmax+1;
        maxs(:,nmax) = [dist(i); force(i)];
    end
end
maxs = maxs(:,1:nmax);
end

