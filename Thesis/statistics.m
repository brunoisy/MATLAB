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

meanPeakForce    = zeros(1,n);
stdPeakForce     = zeros(1,n);
meanPeakDistance = zeros(1,n);
stdPeakDistance  = zeros(1,n);
for i=1:n
    meanPeakForce(i)    = mean(peakForces{i});
    stdPeakForce(i)     = std(peakForces{i});
    meanPeakDistance(i) = mean(peakDistances{i});
    stdPeakDistance(i)  = std(peakDistances{i});
end
meanPeakForce
stdPeakForce
meanPeakDistance
stdPeakDistance
meanPeakDistance./peaks

%%
peak = 2;

peakForces1 = [];
peakForces2 = [];


for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = permLcs{tracenumber};
    Xmins = allXmins{tracenumber};
    Fmins = allFmins{tracenumber};
    [minDiff, j] = min(abs(Lc-templateLc(peak)));
    [minDiff2, j2] = min(abs(Lc-templateLc(peak+1)));
    if minDiff < thresh
        if minDiff2 < thresh && j2 == j+1
            peakForces1 = [peakForces1, Fmins(j)];
        else
            peakForces2 = [peakForces2, Fmins(j)];
        end
        peakForces{i} = [peakForces{i}, Fmins(j)];
    end
end
mean(peakForces1)
std(peakForces1)
mean(peakForces2)
std(peakForces2)
% min
% existence de Lc+ cond à Lc
% tau sur distribution forces, Lc moyen
[h,p] = ttest2(peakForces1,peakForces2,'VarType','unequal')
%https://en.wikipedia.org/wiki/Welch%27s_t-test