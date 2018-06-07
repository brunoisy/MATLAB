function [] = plot_FD_curves(source_directory, dest_directory)
%PLOT_FD_CURVES Summary of this function goes here
%   Detailed explanation goes here

mkdir(dest_directory)
allfiles = dir(source_directory);
subdirs = allfiles([allfiles.isdir]);
files = allfiles(~[allfiles.isdir]);% files that are not directories
filenames = {files(:).name};


for j = 1:length(filenames)
    filename = strcat(source_directory,'/',filenames{j})
    
    name = filenames{j};
    name = name(1:end-4);
    destname = strcat(dest_directory,'/',name,'.eps');
    plot_FD_curve(filename, destname);
end
end

