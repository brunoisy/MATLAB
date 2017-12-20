function [ mins ] = find_min(dist, force)
%FINDMIN Summary of this function goes here
%   Detailed explanation goes here

nmin = 0;% # of minimas found
mins = zeros(2, length(dist));
hi = 20;% size of half comparison interval...

% We find candidate minimas by comparing points to their 2*hi neighbors
for i=1+hi:length(force)-hi
    if force(i) < min([force(i-hi:i-1),force(i+1:i+hi)])
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
    end
end
for i=1:length(force)
    if force(i) < min([force(i-min(i-1,hi):i-1),force(i+1:i+min(hi,length(force)-i))])
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
    end
end
mins = mins(:,1:nmin);

% % We know try to remove the 'noisy' minimas
% % We compute the std on the last 50 points
% % (assumption : those do not represent an  unfolding event)
% % and remove the minimas that are unsufficiently far from the
% % mean (according to the variance)
% 
% k = 4;
% thresh = mean(force(end-50:end))-k*std(force(end-50:end));
% 
% goodmins = zeros(2,nmin);
% ngoodmins = 0;
% for i = 1:nmin
%     if (mins(2,i) < thresh)
%         ngoodmins = ngoodmins+1;
%         goodmins(:,ngoodmins) = mins(:,i);
%     end
% end
% 
% % thresh = 5*10^-9;
% % % we merge 2 similar minimas by taking their average
% % for i = 1:ngoodmins
% %    if goodmins(1,i+1) - goodmins(1,i) < thresh
% %       goodmins(:,i) = (goodmins(:,i+1)+goodmins(:,i))./2;
% %       goodmins(:,i+1:end-1) = goodmins(:,i+2,end);%UGLYUGLYUGLY
% %       ngoodmins = ngoodmins-1;
% %    end
% % end
% 
% goodmins = goodmins(:,1:ngoodmins);

end