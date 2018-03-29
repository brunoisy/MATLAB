% subdir = 'data_1/good/';
% tracenumbers = 1:9;
% 
% subdir = 'data_1/bad/';
% tracenumbers = 1:10;
% 
% subdir = 'data_2/';
% tracenumbers = 1:23;
% 
% subdir = 'data_3/';
% tracenumbers = 1:135;
% 
subdir = 'data_4/';
tracenumbers = 1:119;

% subdir = 'data_6/';
% tracenumbers = 1:166;

xlimits = [-10, 200];
ylimits = [-250, 50];

dir1 = strcat('data/MAT/',subdir);
dir2 = strcat('data/MAT_clean/',subdir);

for tracenumber = tracenumbers
    trace = strcat(dir1,'curve_',int2str(tracenumber),'.mat');
    load(trace)
    
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
    
    trace = strcat(dir2,'curve_',int2str(tracenumber),'.mat');
    load(trace)

    
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
    saveas(gcf, strcat('images/trace cleaning/',subdir,'curve_',int2str(tracenumber),'.jpg'));
    close
end