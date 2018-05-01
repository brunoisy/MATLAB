% number of times each peak is present
% average force of each peak
% presence of next peak conditional on force intensity of current peak
% ...?

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')

templateLc = [33.9368   54.8099   93.2098  118.0897  140.5062];%[34.4800   54.5995   92.3607  118.0434  140.5817];
tracenumbers = 1:100;% [1:17,19:25,27:43,45:52,54:94,96:100];
thresh = 2;

allLcs2 = cell(1,length(tracenumbers));
allXmins = cell(1,length(tracenumbers));
allFmins = cell(1,length(tracenumbers));
% allHasPeaks = cell(1,length(tracenumbers));

for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
    load(trace,'dist','force')
    dist = dist+deltas(tracenumber);
    [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_permissive(dist, force, 4, 4, 20, 10, 3);
    
    Xmins = zeros(1,length(Lc));
    Fmins = zeros(1,length(Lc));
    for i= 1:length(Lc)
        Xseli = Xsel(Xfirst(i) < Xsel & Xsel <= Xunfold(i));
        Fseli = Fsel(Xfirst(i) < Xsel & Xsel <= Xunfold(i));
        [Fmins(i), I] = min(Fseli);
        Xmins(i) = Xseli(I);
    end
    
    %     hasPeaks = false(1,length(templateLc));
    %     for i=1:length(templateLc)
    %         if min(abs(Lc-templateLc(i))) < thresh
    %             hasPeaks(i) = true;
    %         end
    %     end
    
    allLcs2{tracenumber} = Lc;
    allXmins{tracenumber} = Xmins;
    allFmins{tracenumber} = Fmins;
    %     allHasPeaks{tracenumber} = hasPeaks;
end
save('statistics.mat','allLcs2','allXmins','allFmins')

%%
peakForces = cell(1,5);
peakDistances = cell(1,5);
for i=1:5
    peakDistances{i} = [];
    peakForces{i} = [];
end

for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = allLcs2{tracenumber};
    Xmins = allXmins{tracenumber};
    Fmins = allFmins{tracenumber};
    for i=1:length(templateLc)
        [minDiff, j] = min(abs(Lc-templateLc(i)));
        if minDiff < thresh
            peakForces{i} = [peakForces{i}, Fmins(j)];
            peakDistances{i} = [peakDistances{i}, Xmins(j)];
        end
    end
end

meanPeakForce    = zeros(1,5);
stdPeakForce     = zeros(1,5);
meanPeakDistance = zeros(1,5);
for i=1:5
    meanPeakForce(i)    = mean(peakForces{i});
    stdPeakForce(i)     = std(peakForces{i});
    meanPeakDistance(i) = mean(peakDistances{i});
end
meanPeakForce
stdPeakForce
meanPeakDistance
meanPeakDistance./templateLc

%%
peak = 1;

peakForces1 = [];
peakForces2 = [];


for tracenumber = [1:17,19:25,27:43,45:52,54:94,96:100]
    Lc = allLcs2{tracenumber};
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

