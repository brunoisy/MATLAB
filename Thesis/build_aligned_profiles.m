addpath('LSQ fit')
addpath('alignment')

load(strcat('data/FD profiles/data_4.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);%18, 26, 95 -  44, 53 %[1:17,19:25,27:43,45:52,54:94,96:100]

% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

exhLcs = cell(1,length(Lcs_lengths));
allXmins = cell(1,length(tracenumbers));
allFmins = cell(1,length(tracenumbers));
deltas = zeros(1,length(Lcs_lengths));
npeaks = zeros(1,length(Lcs_lengths));
allLcs = [];

for tracenumber = [1:43,45:52,54:100]
    tracenumber
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    thisLc = Lcs{:,tracenumber};
    
    [delta, npeaks(tracenumber)] =  exhaustive_align(templateLc,thisLc,trace);
    load(trace,'dist','force')
    if npeaks(tracenumber) > 1
        dist = dist+delta;
        
        [exhLc, firstinliers, lastinliers] = exhaustive_fit(dist, force);
        exhLcs{tracenumber} = exhLc;
        
        deltas(tracenumber) = delta;
        allLcs = [allLcs, exhLc];
        
        Xmins = zeros(1,length(exhLc));
        Fmins = zeros(1,length(exhLc));
        for i= 1:length(exhLc)
            [Fmins(i), I] = min(force(firstinliers(i):lastinliers(i)));
            Xmins(i) = dist(firstinliers(i)+I);
        end
        allXmins{tracenumber} = Xmins;
        allFmins{tracenumber} = Fmins;
    end
end
allLcs = sort(allLcs);
save('exhaustive_alignedWLC.mat','exhLcs','allXmins','allFmins','deltas','allLcs','npeaks')
% save('alignedWLC.mat','exhLcs','allXmins','allFmins','deltas','allLcs')