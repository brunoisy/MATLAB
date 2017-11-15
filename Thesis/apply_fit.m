addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_1.mat';
%filename = 'data/MAT/data_model/curve_3.mat';
%lsq_fit_fd(filename, 1, true)
RANSAC_fit_fd(filename)

% filename = 'data/MAT/data_2/curve_18.mat';
% fit_fd(filename, 2, true)
% 



