addpath('functions')
addpath('functions_ransac')

% % default limits
xlimits = [-10, 150];
ylimits = [-250, 50];

% subdir = 'data_1/good/';
% filenumbers = 1:9;

% subdir = 'data_1/bad/';
% filenumbers = 1:10;

% subdir = 'data_2/';
% xlimits = [-10, 200];
% ylimits = [-150, 20];
% filenumbers = 1:23;

% subdir = 'data_3/';
% filenumbers = 1:135;

% subdir = 'data_4/';
% filenumbers = 136:159,163:257]

subdir = 'data_5/';
filenumbers = 1:170;




dir = strcat('data/MAT_clean/',subdir);

for filenumber = filenumbers
    filename = strcat(dir,'curve_',int2str(filenumber),'.mat');
    load(filename)
    colors = get(gca, 'colororder');

    
    %%% Plot the initial points
    figure
    subplot(1,3,1)
    hold on
    title('Cleaned Trace');
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist, force,'.')
    
    
    
    %%% Plot the LSQ FD profile
    [Lc, Xsel, Fsel, Xfirst, Xunfold] = LSQ_fit_fd(dist,force);
    subplot(1,3,2)
    hold on
    title('FD profile - LSQ')
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    for i=1:length(Lc)
        X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        F =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
        plot(X,F,'.','Color',colors(mod(i,7)+1,:));
                
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
    end
    
    
    
    %%% Plot the RANSAC FD profile
    [Lc, allInliers] = RANSAC_fit_fd(dist,force);
    subplot(1,3,3)
    hold on
    title('FD profile - RANSAC')
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    for i=1:length(Lc)
        plot(dist(allInliers{i}), force(allInliers{i}),'.','Color',colors(mod(i,7)+1,:))
        
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
    end
    
    
    %%% Save Plots
    %     saveas(gcf, strcat('images/FD fitting/',subdir,'curve_',int2str(filenumber),'.fig'));
    %     saveas(gcf, strcat('images/FD fitting/',subdir,'curve_',int2str(filenumber)),'epsc');
    saveas(gcf, strcat('images/FD fitting/',subdir,'curve_',int2str(filenumber),'.jpg'));
    close
end