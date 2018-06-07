function [] = fit_FD_curves(source_directory, dest_directory)
%FIT_FD_CURVES Summary of this function goes here
%   Detailed explanation goes here

mkdir(dest_directory)
allfiles = dir(source_directory);
subdirs = allfiles([allfiles.isdir]);
files = allfiles(~[allfiles.isdir]);% files that are not directories
filenames = {files(:).name};



for j = 1:length(filenames)
    filename = strcat(source_directory,'/',filenames{j})
    load(filename,'dist','force');
    [Lcs, firstinliers, lastinliers] = exhaustive_fit(dist, force);
    
    name = filenames{j};
    name = name(1:end-4);
    save(strcat(dest_directory,'/',name,'.mat'),'dist','force','Lcs','firstinliers','lastinliers');  
end
end