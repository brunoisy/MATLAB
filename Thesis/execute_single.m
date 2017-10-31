addpath('functions')


kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
global C
C  = kb*T/lp;


filename = 'data/MAT/data_2/curve_2.mat';
%filename = 'data/MAT/data_model/curve_3.mat';
fit_fd(filename, 2, false)

filename = 'data/MAT/data_2/curve_18.mat';
fit_fd(filename, 2, true)




