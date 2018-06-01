addpath('LSQ fit')
addpath('RANSAC fit')
addpath('exhaustive fit')

% % default limits
xlimits = [0, 140];
ylimits = [-200, 20];   %[-250, 50];



subdir = 'data_4/';
dir = strcat('data/MAT_clean/',subdir);
tracenumbers = 1:100;


for tracenumber = 1:5%15%[1:52,54:100]%tracenumbers
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
        dist = dist+deltas(tracenumber);
    
    %%% Plot the initial points
    figure('units','normalized','outerposition',[0 0 1 1]);
    colors = get(gca, 'colororder');
    
    
    %%% Plot the LSQ FD profile
    [Lc, Xsel, Fsel, Xfirst, Xunfold] =  LSQ_fit(dist, force, 4, 10, 10, 10, 10, 5);%
    subplot(1,2,1)
    hold on
    title('Minima Fit')
    set(gca,'FontSize',24)
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist,force,'.','markers',12)
    for i=1:length(Lc)
        X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        F =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        plot(X,F,'.','Color',colors(mod(i,6)+2,:),'markers',12);
        
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,6)+2,:),'LineWidth',2);
    end
    
    %%% Plot the exhaustive FD profile
    [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist, force);
    subplot(1,2,2)
    hold on
    title('Exhaustive Fit')
    set(gca,'FontSize',24)
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
%     ylabel('Force (pN)');
    plot(dist, force,'.','markers',12)
    for i=1:length(Lcs)
        plot(dist(firstinliers(i):lastinliers(i)), force(firstinliers(i):lastinliers(i)),'.','Color',colors(mod(i,6)+2,:),'markers',12)
        
        Xfit = linspace(0,Lcs(i),1000);
        Ffit = fd(Lcs(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,6)+2,:), 'LineWidth',2);
    end
    
    
   
    
    
    %%% Save Plots
%     saveas(gcf, strcat('images/LSQ - Exhaustive fit/curve_',int2str(tracenumber),'.jpg'));
%             saveas(gcf, strcat('images/LSQ - Exhaustive fit - post align/curve_',int2str(tracenumber),'.jpg'));
%     close
end