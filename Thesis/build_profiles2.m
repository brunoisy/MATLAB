load('constants.mat')
addpath('LSQ fit')

% directory = 'data/MAT_clean/LmrP Proteoliposomes/20170305/Tip2-B_LmrP Proteoliposomes/Analysis/exported events - all positions';
directory = 'data/MAT_clean/LmrP Proteoliposomes/20170305/Tip4-B_LmrP Proteoliposomes/Analysis/exported events - all positions';


allfiles = dir(directory);
files = allfiles(~[allfiles.isdir]);% files that are not directories
nfiles = length(allfiles);

Lcs = cell(1, nfiles);
Lcs_lengths = zeros(1,nfiles);

filenames = {files(:).name};
for i =1:length(filenames)
    filename = strcat(directory,'/',filenames{i});
    load(filename);
    [Lc, ~, ~, ~, ~] = LSQ_fit_fd(dist,force);
    Lcs{i} = Lc;
    Lcs_lengths(i) = length(Lc);
end


newdir = strcat('data/FD profiles/LmrP Proteoliposomes_tip4');
save(strcat(newdir,'.mat'),'Lcs','Lcs_lengths');
