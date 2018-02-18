addpath('functions')
addpath('functions_ransac')

% subdir = 'data_1/good/';
% filenumbers = 1:9;

% subdir = 'data_1/bad/';
% filenumbers = 1:10;

% subdir = 'data_2/';
% filenumbers = 1:23;

% subdir = 'data_3/';
% filenumbers = 1:135;

% subdir = 'data_4/';
% filenumbers = 136:271;

subdir = 'data_5/';
filenumbers = 1:170;

xlimits = [-10, 200];
ylimits = [-250, 50];

dir1 = strcat('data/MAT/',subdir);
dir2 = strcat('data/MAT_clean/',subdir);

for filenumber = filenumbers
    filename = strcat(dir1,'curve_',int2str(filenumber),'.mat');
    load(filename)
    
    %%% Plot the initial points
    figure
    subplot(1,2,1)
    hold on
    title('Initial Trace');
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist, force,'.')
    
    filename = strcat(dir2,'curve_',int2str(filenumber),'.mat');
    load(filename)
    colors = get(gca, 'colororder');

    
    %%% Plot the initial points
    subplot(1,2,2)
    hold on
    title('Cleaned Trace');
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist, force,'.')
    
    %%% Save Plot
    saveas(gcf, strcat('images/Trace cleaning/',subdir,'curve_',int2str(filenumber),'.jpg'));
    close
end