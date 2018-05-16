addpath('LSQ fit')
addpath('alignment')

load(strcat('data/FD profiles/data_4.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);%18, 26, 95 -  44, 53 %[1:17,19:25,27:43,45:52,54:94,96:100]

% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

xlimits = [-10, 150];
ylimits = [-200, 50];

for tracenumber = 43
 %[2    12    19    20    22    25    39    42    43    60    64    66    67    68    70    73    80    83  84    87    98]
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    thisLc = Lcs{:,tracenumber};
    
    [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
    load(trace,'dist','force')
    dist = dist+delta;
    figure
    colors = get(gca, 'colororder');
    hold on
    xlim(xlimits);
    ylim(ylimits);
    plot(dist,force,'.');
    for i = 1:length(templateLc)
        Xfit = linspace(0,templateLc(i),1000);
        Ffit = fd(templateLc(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:)); 
    end
end
