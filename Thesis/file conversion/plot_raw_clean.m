addpath('LSQ fit')
addpath('RANSAC fit')

xlimits = [-10, 150];
ylimits = [-200, 100];

subdir = 'data_4/';

tracenumber = 6;



%%% Plot the initial points
dir = strcat('data/MAT/',subdir);
trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
load(trace)

figure('units','normalized','outerposition',[0 0 1 1]);
colors = get(gca, 'colororder');
hold on
title('Raw FD Curve')
set(gca,'FontSize',24)

xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
plot(dist,force,'.','markers',12)

%%% Plot the initial points
dir = strcat('data/MAT_clean/',subdir);
trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
load(trace)

figure('units','normalized','outerposition',[0 0 1 1]);
colors = get(gca, 'colororder');
hold on
title('Processed FD Curve')
set(gca,'FontSize',24)

xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
plot(dist,force,'.','markers',12)
