load('constants.mat')
addpath('LSQ fit')

subdir = 'data_4';
directory = strcat('data/MAT_clean/',subdir,'/');
tracenumbers = 1:100;

Lcs = cell(1, length(tracenumbers));
Lcs_lengths = zeros(1,length(tracenumbers));

for i = 1:length(tracenumbers)
    trace = strcat(directory,'curve_',int2str(tracenumbers(i)),'.mat')
    load(trace);
    [Lc, ~, ~, ~, ~] = LSQ_fit(dist, force, 4, 10, 10, 10, 10, 5);
    Lcs{i} = Lc;
    Lcs_lengths(i) = length(Lc);
end

newdir = strcat('data/FD profiles/',subdir);
save(strcat(newdir,'.mat'),'Lcs','Lcs_lengths');
