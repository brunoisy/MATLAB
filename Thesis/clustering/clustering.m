addpath('LSQ fit')
addpath('RANSAC fit')

xlimits = [-10, 150];
ylimits = [-250, 50];

directory = 'data_4';
tracenumbers = [136:187,201:271];
load(strcat('data/FD profiles/',directory,'.mat'))
Lcs = Lcs(tracenumbers-135);
Lcs_lengths = Lcs_lengths(tracenumbers-135);
% histogram(Lcs_lengths)

%%% clustering with RANSAC
thresh = 5 %MSE tresh
for n = 3:6
    figure
    hold on
    colors = get(gca, 'colororder');
    for subcluster = 1:2 % number of subclusters to find
        if subcluster==1
            Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
        else
            outliers = true(1, sum(Lcs_lengths==n));
            outliers(inliers) = false;
            Lcs_cluster = Lcs_cluster(:,outliers);
        end
        [meanLc, inliers, deltas] = ransac_clustering(Lcs_cluster,@fittingfn_clustering,@distfn_clustering,3,thresh*subcluster,true,50);

        
        %%% Plotting
        subplot(1,2,subcluster)
        hold on
        title(strcat('clustered FD profile for n = ',int2str(n)))
        
        xlim(xlimits);
        ylim(ylimits);
        xlabel('Distance (nm)');
        ylabel('Force (pN)');
        for i=1:length(meanLc)
            Xfit = linspace(0,meanLc(i),1000);
            Ffit = fd(meanLc(i), Xfit);
            plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
        end
        
        oktracenumbers = tracenumbers(Lcs_lengths == n);% select all traces with the right Lc length
        if subcluster ~=1
            oktracenumbers = oktracenumbers(outliers);
        end
        
        for i = 1:length(inliers)
            tracenumber = oktracenumbers(inliers(i));
            trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
            load(trace)
            plot(dist+deltas(i), force,'.')
        end
    end
end