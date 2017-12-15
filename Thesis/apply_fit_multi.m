addpath('functions')
addpath('functions_ransac')

% directory = 'data/MAT/data_1/good/';
% directory = 'data/MAT/data_1/bad/';
% xlimits = [-10, 150];
% ylimits = [-250, 100];

% directory = 'data/MAT/data_2/';
% xlimits = [-10, 200];
% ylimits = [-150, 20];

% directory = 'data/MAT/data_3/';
% xlimits = [-10, 200];
% ylimits = [-200, 50];


% directory = 'data/MAT/data_4/';
% xlimits = [-10, 200];
% ylimits = [-200, 50];

directory = 'data/MAT/data_5/';
xlimits = [-10, 150];
ylimits = [-250, 20];



for filenumber =8
     filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
%      load(filename)
%      figure
%      hold on
%      xlim(xlimits)
%      ylim(ylimits)
%      plot(dist,force,'.')
%      saveas(gcf, strcat('images/data_4/curve_',int2str(filenumber),'.jpg'));
%      close
     
      RANSAC_fit_fd(filename, xlimits, ylimits)
%      saveas(gcf, strcat('images/data_4/curve_',int2str(filenumber),'.jpg'));
%      close
     
%    lsq_fit_fd(filename, xlimits, ylimits, 1, false)
%     saveas(gcf, strcat('images/LSQ fit/data_2/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/LSQ fit/data_2/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/LSQ fit/data_2/curve_',int2str(filenumber),'.jpg'));

%     saveas(gcf, strcat('images/LSQ fit/data_1/good/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/LSQ fit/data_1/good/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/LSQ fit/data_1/good/curve_',int2str(filenumber),'.jpg'));

%     saveas(gcf, strcat('images/LSQ fit/data_1/bad/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/LSQ fit/data_1/bad/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/LSQ fit/data_1/bad/curve_',int2str(filenumber),'.jpg'));
    
%      RANSAC_fit_fd(filename, xlimits, ylimits)
%     saveas(gcf, strcat('images/RANSAC/data_2/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/RANSAC/data_2/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/RANSAC/data_2/curve_',int2str(filenumber),'.jpg'));
% 
%     saveas(gcf, strcat('images/RANSAC/data_1/good/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/RANSAC/data_1/good/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/RANSAC/data_1/good/curve_',int2str(filenumber),'.jpg'));
%     
%     saveas(gcf, strcat('images/RANSAC/data_1/bad/curve_',int2str(filenumber),'.fig'));
%     saveas(gcf, strcat('images/RANSAC/data_1/bad/curve_',int2str(filenumber)),'epsc');
%     saveas(gcf, strcat('images/RANSAC/data_1/bad/curve_',int2str(filenumber),'.jpg'));
%      close
end