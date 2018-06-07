peaks = [34.4800, 43.5, 54.5995,  77,  92.3607,  118.0434,  140.5817];
n = length(peaks);
thresh = 1.5;
peakDistances = cell(1,n);
peakForces = cell(1,n);
for i=1:n
    peakDistances{i} = [];
    peakForces{i} = [];
end
for tracenumber = 1:100
    if npeaks(tracenumber) >=1
        Lc = exhLcs{tracenumber};
        Xmins = allXmins{tracenumber};
        Fmins = allFmins{tracenumber};
        for i=1:n
            [minDiff, j] = min(abs(Lc-peaks(i)));
            if minDiff < thresh
                peakDistances{i} = [peakDistances{i}, Xmins(j)];
                peakForces{i} = [peakForces{i}, Fmins(j)];
            end
        end
    end
end

instancesPeak    = zeros(1,n);
meanPeakForce    = zeros(1,n);
stdPeakForce     = zeros(1,n);
meanPeakDistance = zeros(1,n);
stdPeakDistance  = zeros(1,n);
for i=1:n
    instancesPeak(i)    = length(peakForces{i});
    meanPeakForce(i)    = mean(peakForces{i});
    stdPeakForce(i)     = std(peakForces{i});
    meanPeakDistance(i) = mean(peakDistances{i});
    stdPeakDistance(i)  = std(peakDistances{i});
end

instancesPeak
round(meanPeakForce,2)
round(stdPeakForce,2)
round(meanPeakDistance,2)
round(stdPeakDistance,2)
round(meanPeakDistance./peaks,2)
