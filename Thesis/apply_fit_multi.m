addpath('functions')
addpath('functions_ransac')


% xlimits = [-10, 150]; % data_1
% ylimits = [-250, 100];

subdir = 'data_2/';
xlimits = [-10, 200];
ylimits = [-150, 20];
filenumbers = 2;%1:23;

% subdir = 'data_3';
% xlimits = [-10, 200];
% ylimits = [-200, 50];

% subdir = 'data_4';
% xlimits = [-10, 200];
% ylimits = [-200, 50];

% subdir = 'data_5';
% xlimits = [-10, 150];
% ylimits = [-250, 20];

dir = strcat('data/MAT_clean/',subdir);

for filenumber = filenumbers
    filename = strcat(dir,'curve_',int2str(filenumber),'.mat');
    load(filename)
    
    %%% Plot the initial points
    figure
    subplot(1,3,1)
    hold on
    title('Initial Datapoints');
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist, force,'.')
    
    
    
    %%% Plot the LSQ FD profile
    [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_fd(force,dist);
    subplot(1,3,2)
    hold on
    title('FD profile fit to minimum lsq')
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    for i=1:length(Lc)
        X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        F =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        plot(X,F,'.');
                
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit);
    end
    
    
    
    %%% Plot the RANSAC FD profile
    [Lc, allInliers] = RANSAC_fit_fd(force,dist);
    Lc
    subplot(1,3,3)
    hold on
    title('FD profile fit to RANSAC')
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    for i=1:length(Lc)
        plot(dist(allInliers{i}), force(allInliers{i}),'.')
        
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit);
    end
    
    
    %%% Save Plots
    %     saveas(gcf, strcat('images/FD_fitting/',subdir,'curve_',int2str(filenumber),'.fig'));
    %     saveas(gcf, strcat('images/FD_fitting/',subdir,'curve_',int2str(filenumber)),'epsc');
    saveas(gcf, strcat('images/FD_fitting/',subdir,'curve_',int2str(filenumber),'.jpg'));
    %     close
end