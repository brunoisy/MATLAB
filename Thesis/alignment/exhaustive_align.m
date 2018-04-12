function delta = exhaustive_align(templateLc, Lc)
%MSEALIGN Summary of this function goes here
%   Detailed explanation goes here

thresh = 5;% nm
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
delta = bestDelta;

end

