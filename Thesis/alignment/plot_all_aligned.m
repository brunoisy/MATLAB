addpath('LSQ fit')

% % default limits
xlimits = [-10, 150];
ylimits = [-200, 50];%[-250, 50];


subdir = 'data_4/';
tracenumbers = 1:100; %1:10%1:119;


dir = strcat('data/MAT_clean/',subdir);

figure('units','normalized','outerposition',[0 0 1 1]);
hold on
title('aligned FD curves')
set(gca,'FontSize',24)

xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

for tracenumber =  [1:17,19:25,27:43,45:52,54:94,96:100]
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
    deltas(tracenumber);
    dist = dist+deltas(tracenumber);
    
    plot(dist,force,'b.','markers',1)
        
end