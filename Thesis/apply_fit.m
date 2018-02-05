addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT_clean/data_2/curve_16.mat';
xlimits = [-10, 200];
ylimits = [-150, 20];
% filename = 'data/MAT/data_1/curve_1.mat';
% xlimits = [-10, 150];
% ylimits = [-250, 100];

% lsq_fit_fd(filename,xlimits,ylimits,1,true,true)
% lsq_fit_fd(filename, xlimits, ylimits, 1, false)
RANSAC_fit_fd(filename, xlimits, ylimits)