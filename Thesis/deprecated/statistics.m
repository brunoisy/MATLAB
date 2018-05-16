% number of times each peak is present
% average force of each peak
% presence of next peak conditional on force intensity of current peak
% ...?
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

load('alignedWLC.mat')
peakDistances = cell(1,5);
peakForces = cell(1,5);
for i=1:5
    peakDistances{i} = [];
    peakForces{i} = [];
end
thresh = 2;


hasPeaks = zeros(100,5);
% zero if corresponding trace doesn't contain peak, otherwise number of corresponding peak in trace


for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = permLcs{tracenumber};
    Xmins = allXmins{traacenumber};
    Fmins = allFmins{tracenumber};
    for i=1:length(templateLc)
        [minDiff, j] = min(abs(Lc-templateLc(i)));
        if minDiff < thresh
            hasPeaks(tracenumber,i) = j;
            peakDistances{i} = [peakDistances{i}, Xmins(j)];
            peakForces{i} = [peakForces{i}, Fmins(j)];
        end
    end
end

meanPeakForce    = zeros(1,5);
stdPeakForce     = zeros(1,5);
meanPeakDistance = zeros(1,5);
stdPeakDistance  = zeros(1,5);
for i=1:5
    meanPeakForce(i)    = mean(peakForces{i});
    stdPeakForce(i)     = std(peakForces{i});
    meanPeakDistance(i) = mean(peakDistances{i});
    stdPeakDistance(i)  = std(peakDistances{i});
end
meanPeakForce
stdPeakForce
meanPeakDistance
stdPeakDistance
meanPeakDistance./templateLc

%%
peak1 = 77;
thresh1 = 3;
hasPeak1 = [];

for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]
    if min(abs(permLcs{tracenumber}-peak1)) < thresh1
        hasPeak1 = [hasPeak1, tracenumber];
    end
end

peakForces2 = peakForces{2};
meanPeakForces2ifPeak77 = mean(peakForces2(hasPeak1))






%
% peak = 1;
%
% peakForces1 = [];
% peakForces2 = [];
%
%
% for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
%     Lc = permLcs{tracenumber};
%     Xmins = allXmins{tracenumber};
%     Fmins = allFmins{tracenumber};
%     [minDiff, j] = min(abs(Lc-templateLc(peak)));
%     [minDiff2, j2] = min(abs(Lc-templateLc(peak+1)));
%     if minDiff < thresh
%         if minDiff2 < thresh && j2 == j+1
%             peakForces1 = [peakForces1, Fmins(j)];
%         else
%             peakForces2 = [peakForces2, Fmins(j)];
%         end
%         peakForces{i} = [peakForces{i}, Fmins(j)];
%     end
% end
% mean(peakForces1)
% std(peakForces1)
% mean(peakForces2)
% std(peakForces2)
% % min
% % existence de Lc+ cond à Lc
% % tau sur distribution forces, Lc moyen
%
