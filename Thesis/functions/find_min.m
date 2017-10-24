function [ mins ] = find_min(dist, force, maxmin, fthresh)
%FINDMIN Summary of this function goes here
%   Detailed explanation goes here

if(nargin <4)
    fthresh = -25*10^-12;% max value of force for a candidate to be considered a minima
end
nmin = 0;% # of minimas found
mins = zeros(2, maxmin);
hi = 20;% size of half comparison interval...

for i=1+hi:length(force)-hi
    if ( (force(i) < min([force(i-hi:i-1),force(i+1:i+hi)])) && (force(i) < fthresh))
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
        if(nmin >= maxmin)
            break
        end
    end
end
%mins = mins(:,2:nmin);% starting at 2 'cause first min is always bad !!!
end

