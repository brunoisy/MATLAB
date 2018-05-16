% number of times each peak is present
% average force of each peak
% presence of next peak conditional on force intensity of current peak
% ...?
peaks = [34.4800,   54.5995,  77,  92.3607,  118.0434,  140.5817];
n = length(peaks);
load('alignedWLC.mat')
thresh = 2;
peakDistances = cell(1,n);
peakForces = cell(1,n);
for i=1:n
    peakDistances{i} = [];
    peakForces{i} = [];
end
% zero if corresponding trace doesn't contain peak, otherwise number of corresponding peak in trace
for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]
    Lc = permLcs{tracenumber};
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

instancesPeak    =zeros(1,n);
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
meanPeakForce
stdPeakForce
meanPeakDistance
stdPeakDistance
meanPeakDistance./peaks
