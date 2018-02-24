load('constants.mat')
addpath('LSQ fit')
addpath('RANSAC fit')

xlimits = [-10, 150];
ylimits = [-250, 50];

directory = 'data_4';
tracenumbers = [136:187,201:271];
load(strcat('data/FD profiles/',directory,'.mat'))
Lcs = Lcs(tracenumbers-135);
Lcs_lengths = Lcs_lengths(tracenumbers-135);


%%% clustering with RANSAC
thresh = 40; %MSE tresh
figure
hold on
colors = get(gca, 'colororder');
for n = 3:6
    Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
    
    inliers = ransac_clustering(Lcs_cluster,@fittingfn_clustering,@distfn_clustering,3,thresh,true,50);
    Lc = mean(Lcs_cluster(:,inliers),2);
    [inliers,deltas] = distfn_clustering(Lc, Lcs_cluster, thresh);
    
    %%% Plotting
    subplot(2,2,n-2)
    hold on
    title(strcat('clustered FD profile for n = ',int2str(n)))
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    for i=1:length(Lc)
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
    end
    
    oktracenumbers = tracenumbers(Lcs_lengths == n);% select all traces with the right Lc length
    for i = 1:length(inliers)
        tracenumber = oktracenumbers(inliers(i));
        trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        load(trace)
        plot(dist+deltas(i), force,'.')
    end
end