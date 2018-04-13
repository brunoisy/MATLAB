function [totalDelta, peaks] = exhaustive_align(templateLc, Lc, trace)
%MSEALIGN Summary of this function goes here
%   Detailed explanation goes here

thresh = 3;% nm
totalDelta = 0;
for it=1:5
    maxPeaks = 0;
    minError = Inf;
    bestDelta = 0;
    
    for i = 1:length(Lc)
        for j=1:length(templateLc)
            delta = templateLc(j)-Lc(i);
            shiftedLc = Lc+delta;
            
            peaks = 0;
            error = 0;
            for k = 1:length(shiftedLc)
                if min(abs(templateLc-shiftedLc(k))) < thresh
                    peaks = peaks + 1;
                    error = error + min(abs(templateLc-shiftedLc(k)))^2;
                end
                
            end
            if(peaks>maxPeaks || (peaks==maxPeaks && error < minError))
                maxPeaks = peaks;
                minError = error;
                bestDelta = delta;
            end
        end
    end
    peaks = maxPeaks;
    totalDelta = totalDelta+bestDelta;
    load(trace,'dist','force')
    dist = dist+totalDelta;
    [Lc,~,~,~,~] = LSQ_fit_fd(dist, force);
end
end

