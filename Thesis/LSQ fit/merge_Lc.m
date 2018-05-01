function [Lc, Xfirst, Xlast] = merge_Lc(Lc,Xfirst, Xlast, merge_thresh)
%MERGELC Summary of this function goes here
%   Detailed explanation goes here

if nargin < 4
    merge_thresh = 10;
end
nmin = length(Lc);
% if(nargin == 2)
%     Xfirst = zeros(1,nmin);
%     Xlast = zeros(1,nmin);
% end

% We merge Lc's that are too similar
for i = 1:nmin-1
    if(i<=nmin-1)%very ugly, but necessary (could be better though)
        if (Lc(i+1)-Lc(i))<merge_thresh
            %         Lc(i) = (Lc(i+1)+Lc(i))/2;
            %         Lc(i+1:end-1) = Lc(i+2:end);
            Lc(i:end-1) = Lc(i+1:end);
            Xfirst(i+1:end-1) = Xfirst(i+2:end);
            Xlast(i:end-1) = Xlast(i+1:end);
            
            nmin = nmin-1;
        end
    end
end
Lc = Lc(1:nmin);
Xfirst = Xfirst(1:nmin);
Xlast = Xlast(1:nmin);
end

