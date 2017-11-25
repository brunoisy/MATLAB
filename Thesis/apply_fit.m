addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_4.mat';
%filename = 'data/MAT/data_model/curve_3.mat';
%lsq_fit_fd(filename, 1, true)
xlimits = [-10, 200];
ylimits = [-150, 200];
RANSAC_fit_fd(filename, xlimits, ylimits)

% filename = 'data/MAT/data_2/curve_18.mat';
% fit_fd(filename, 2, true)
%



