function [delta, npeaks] = exhaustive_align(templateLc, Lc, trace)
%MSEALIGN Summary of this function goes here
%   Detailed explanation goes here


thresh = 1.5;% nm +-1.5 = range of 3
maxPeaks = 0;
minError = Inf;
bestDelta = 0;

for bigDelta = round(6-Lc(1)):2:50
    load(trace,'dist','force')
    dist = dist+bigDelta;
    [upLc,~,~,~,~] = LSQ_fit_fd(dist, force); % could be computed once and for all!
    for smallDelta = -1:0.1:1
        shiftedLc = upLc+smallDelta;
        peaks = zeros(1, length(templateLc));
        error = 0;
        
        for i = 1:length(templateLc)
            if min(abs(templateLc(i)-shiftedLc)) < thresh
                peaks(i) = 1;
                error = error + min(abs(templateLc(i)-shiftedLc))^2;
            end
        end
        
        if sum(peaks)>maxPeaks || (sum(peaks)==maxPeaks && error < minError)
            maxPeaks = sum(peaks);
            minError = error;
            bestDelta = bigDelta+smallDelta;
        end
    end
end

npeaks = maxPeaks;
if maxPeaks == 1
    delta = 0; % we have not managed to align
else
    delta = bestDelta;
end

end
