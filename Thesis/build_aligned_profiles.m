addpath('LSQ fit')
addpath('alignment')

load(strcat('data/FD profiles/data_4.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);%18, 26, 95 -  44, 53 %[1:17,19:25,27:43,45:52,54:94,96:100]

% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

permLcs = cell(1,length(Lcs_lengths));
allXmins = cell(1,length(tracenumbers));
allFmins = cell(1,length(tracenumbers));
deltas = zeros(1,length(Lcs_lengths));
allLcs = [];

for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]%tracenumbers
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    thisLc = Lcs{:,tracenumber};
    
    [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
    load(trace,'dist','force')
    dist = dist+delta;
    [permLc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit(dist, force, 4, 7, 10, 10, 5, 5);%permissive
    permLcs{tracenumber} = permLc;
    
    deltas(tracenumber) = delta;
    allLcs = [allLcs, permLc];
    
    Xmins = zeros(1,length(permLc));
    Fmins = zeros(1,length(permLc));
    for i= 1:length(permLc)
        Xseli = Xsel(Xfirst(i) < Xsel & Xsel <= Xunfold(i));
        Fseli = Fsel(Xfirst(i) < Xsel & Xsel <= Xunfold(i));
        [Fmins(i), I] = min(Fseli);
        Xmins(i) = Xseli(I);
    end
    allXmins{tracenumber} = Xmins;
    allFmins{tracenumber} = Fmins;
end
allLcs = sort(allLcs);
save('alignedWLC.mat','permLcs','allXmins','allFmins','deltas','allLcs')