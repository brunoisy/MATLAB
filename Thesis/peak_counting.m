addpath('LSQ fit')

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);
xlimits = [0, 150];
ylimits = [-300, 50];
% completeLc = [9,39,41,68,71,93,95,129,134,160,163,186,203,214,244,257,283,288,308,312,341,346,371,376,405,408]*.36;
% completeLc = [12,36,42,67,74,93,105,126,138,161,167,187,216,234,262,280,292,310,316,338,350,371,377,399]*.36;
% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

updLcs = cell(1,length(Lcs_lengths));



for n = 2:8
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1:length(clusterLcs(1,:))
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
        %         if tracenumber == 12
        
        trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        thisLc = clusterLcs(:,i)';
        
        [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
        load(trace,'dist','force')
        dist = dist+delta;
        [updLc,~,~,~,~] = LSQ_fit_permissive(dist, force, 2, 5, 8, 4);
        updLcs{tracenumber} = updLc;
        
        %end
    end
end