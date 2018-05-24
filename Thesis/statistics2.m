% question : is presence of peak influenced by intensity of previous peak?
% (especially third peak!)
% -> measure force of second peak when no third peak
% -> measure force of second peak when third peak
% -> compare two sets using ttest (can same mean/variance be rejected?)


peaks = [34.4800,   54.5995,  78,  92.3607,  118.0434,  140.5817];
thresh = 2;
analysedPeak = 2;

peakForces1 = [];
peakForces2 = [];


for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = exhLcs{tracenumber};
    Xmins = allXmins{tracenumber};
    Fmins = allFmins{tracenumber};
    [minDiff, j] = min(abs(Lc-peaks(analysedPeak)));
    [minDiff2, j2] = min(abs(Lc-peaks(analysedPeak+1)));
    if minDiff < thresh
        if minDiff2 < thresh && j2 == j+1 % peak and peak+1 are present
            peakForces1 = [peakForces1, Fmins(j)];
        else % peak present, peak+1 absent
            peakForces2 = [peakForces2, Fmins(j)];
        end
    end
end
mean(peakForces1)
std(peakForces1)
mean(peakForces2)
std(peakForces2)


[h,p] = ttest2(peakForces1,peakForces2)
% [h,p] = ttest2(peakForces1,peakForces2,'VarType','unequal')
%https://en.wikipedia.org/wiki/Welch%27s_t-test
%%

peak = 3;
previousPeak = [];
for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = permLcs{tracenumber};
    
    [minDiff, j] = min(abs(Lc-peaks(peak)));
    if minDiff < thresh
        if j==1
            previousPeak = [previousPeak, 0];
        else
            previousPeak = [previousPeak, Lc(j-1)];
        end
    end
end