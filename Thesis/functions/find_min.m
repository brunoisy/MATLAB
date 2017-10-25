function [ goodmins ] = find_min(dist, force)
%FINDMIN Summary of this function goes here
%   Detailed explanation goes here

nmin = 0;% # of minimas found
mins = zeros(2, length(dist));
hi = 40;% size of half comparison interval...

% We find candidate minimas by comparing points to their 2*hi neighbors
% ! danger, risk of missing first minima
for i=1+hi:length(force)-hi
    if force(i) < min([force(i-hi:i-1),force(i+1:i+hi)])
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
    end
end

% We know try to remove the 'noisy' minimas
% We compute the std on the last 50 points
% (assumption : those do not represent an  unfolding event)
% and remove the minimas that are unsufficiently far from the
% mean (according to the variance)

k = 4;
thresh = mean(force(end-50:end))-k*std(force(end-50:end));

goodmins = zeros(2,nmin);
ngoodmins = 0;
for i = 1:nmin
    if (mins(2,i) < thresh)
        ngoodmins = ngoodmins+1;
        goodmins(:,ngoodmins) = mins(:,i);
    end
end

goodmins = goodmins(:,1:ngoodmins);

end