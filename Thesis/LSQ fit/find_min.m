function [ mins ] = find_min(dist, force, min_thresh)
%FINDMIN Summary of this function goes here
%   Detailed explanation goes here
% min_thresh size of half comparison interval...

nmin = 0;% # of minimas found
mins = zeros(2, length(dist));

% We find candidate minimas by comparing points to their 2*hi neighbors
for i=1:length(force)
    if force(i) < min([force(i-min(i-1,min_thresh):i-1),force(i+1:i+min(min_thresh,length(force)-i))])
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
    end
end
mins = mins(:,1:nmin);
end