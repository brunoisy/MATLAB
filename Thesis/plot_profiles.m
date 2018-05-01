addpath('LSQ fit')
addpath('RANSAC fit')

% % default limits
xlimits = [-10, 150];
ylimits = [-200, 50];%[-250, 50];

% subdir = 'data_1/good/';
% tracenumbers = 1:9;
%
% subdir = 'data_1/bad/';
% tracenumbers = 1:10;
%
% subdir = 'data_2/';
% xlimits = [-10, 200];
% ylimits = [-150, 20];
% tracenumbers = 1:23;
%
% subdir = 'data_3/';
% tracenumbers = 1:135;

subdir = 'data_4/';
tracenumbers = 1:100; %1:10%1:119;

% subdir = 'data_5/';
% tracenumbers = 1:170;




dir = strcat('data/MAT_clean/',subdir);


for tracenumber =  1:100%3%:5%tracenumbers
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
    
    
    %%% Plot the initial points
    figure('units','normalized','outerposition',[0 0 1 1]);
    colors = get(gca, 'colororder');
    
    
    
    %%% Plot the LSQ FD profile
    [Lc, Xsel, Fsel, Xfirst, Xunfold] =  LSQ_fit_fd(dist, force, 2, false, 10, 12);%
%     subplot(1,2,1)
    hold on
    title('FD profile - LSQ')
    set(gca,'FontSize',22)
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist,force,'.')
%     for i=1:length(Lc)
%         X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
%         F =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
%         plot(X,F,'.','Color',colors(mod(i,7)+1,:));
%         
%         Xfit = linspace(0,Lc(i),1000);
%         Ffit = fd(Lc(i), Xfit);
%         plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
%     end
    
    
    
%     %%% Plot the RANSAC FD profile
%     [Lc, allInliers] = RANSAC_fit_fd(dist,force, 50);
%     subplot(1,2,2)
%     hold on
%     title('FD profile - RANSAC')
%     set(gca,'FontSize',22)
%     
%     xlim(xlimits);
%     ylim(ylimits);
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
%     plot(dist, force,'.')
%     for i=1:length(Lc)
%         plot(dist(allInliers{i}), force(allInliers{i}),'.','Color',colors(mod(i,7)+1,:))
%         
%         Xfit = linspace(0,Lc(i),1000);
%         Ffit = fd(Lc(i), Xfit);
%         plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:));
%     end
    
    
    %%% Save Plots
    %     saveas(gcf, strcat('images/FD fitting/',subdir,'curve_',int2str(tracenumber),'.fig'));
    %     saveas(gcf, strcat('images/FD fitting/',subdir,'curve_',int2str(tracenumber)),'epsc');
    saveas(gcf, strcat('images/plop/curve_',int2str(tracenumber),'.jpg'));
    close
end