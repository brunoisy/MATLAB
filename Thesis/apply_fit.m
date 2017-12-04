addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_9.mat';
%lsq_fit_fd(filename, 1, true)
xlimits = [-10, 200];
ylimits = [-150, 200];
RANSAC_fit_fd(filename, xlimits, ylimits)