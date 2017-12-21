function [ mins ] = find_min(dist, force)
%FINDMIN Summary of this function goes here
%   Detailed explanation goes here

nmin = 0;% # of minimas found
mins = zeros(2, length(dist));
hi = 20;% size of half comparison interval...

% We find candidate minimas by comparing points to their 2*hi neighbors
for i=1:length(force)
    if force(i) < min([force(i-min(i-1,hi):i-1),force(i+1:i+min(hi,length(force)-i))])
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
    end
end
mins = mins(:,1:nmin);
end