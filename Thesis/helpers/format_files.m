% Warning: /curves_LmrP_proteoliposomes/good/curve1 has forces of order
% 10^-15 instead of 10^-18

directory = '../diverse_data/';
%'../curves_LmrP_proteoliposomes/good/';
%'../curves_LmrP_proteoliposomes/bad/';
%
files = dir(directory);
files = files([files.isdir]==false);

filenames = {files(:).name};
for i = 1:length(filenames)
    comma2point_overwrite(strcat(directory,filenames{i}))% change commas to points
end