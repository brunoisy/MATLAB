addpath('LSQ fit')
addpath('RANSAC fit')
addpath('exhaustive fit')

% % default limits
xlimits = [0, 140];
ylimits = [-100, 20];   %[-250, 50];



subdir = 'data_4/';
dir = strcat('data/MAT_clean/',subdir);
tracenumbers = 1:100;


for tracenumber = 13%[1:52,54:100]%tracenumbers
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
%         dist = dist+deltas(tracenumber);
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    colors = get(gca, 'colororder');
  
    
    %%% Plot the exhaustive FD profile
    [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist, force);
    subplot(1,2,1)
    hold on
    title('Fixed Orgin')
    set(gca,'FontSize',24)
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist, force,'.','markers',12)
    for i=1:length(Lcs)
        plot(dist(firstinliers(i):lastinliers(i)), force(firstinliers(i):lastinliers(i)),'.','Color',colors(mod(i,6)+2,:),'markers',12)
        
        Xfit = linspace(0,Lcs(i),1000);
        Ffit = fd(Lcs(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,6)+2,:),'LineWidth',2);
    end
    
    
    %%% Plot the exhaustive FD profile
    [Lcs, firstinliers, lastinliers, delta] = exhaustive_free_offset(dist, force);
    dist = dist+delta;
    subplot(1,2,2)
    hold on
    title('Free Offset')
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
        plot(Xfit,Ffit,'Color',colors(mod(i,6)+2,:),'LineWidth',2);
    end
    h = plot(delta,0,'.','markers',30,'Color',colors(7,:));

    legend(h, {'previous origin'})
    delta
    
    %%% Save Plots
%     saveas(gcf, strcat('images/LSQ - Exhaustive fit/curve_',int2str(tracenumber),'.jpg'));
%             saveas(gcf, strcat('images/LSQ - Exhaustive fit - post align/curve_',int2str(tracenumber),'.jpg'));
%     close
end