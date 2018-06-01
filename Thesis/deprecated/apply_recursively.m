function [] = apply_recursively(fun, directory, destination)
% This function recursively applies function fun to all files in directory 
% and its subdirectories, storing the result in

mkdir(destination)
allfiles = dir(directory);
subdirs = allfiles([allfiles.isdir]);
files = allfiles(~[allfiles.isdir]);% files that are not directories
filenames = {files(:).name};
for j =1:length(filenames)
    filename = strcat(directory,'/',filenames{j});
    name = filenames{j};
    
    name = name(1:end-4);
    feval(fun, filename, destination, name);
end

for i = 1:length(subdirs)
    subdir = subdirs(i);
    if ~strcmp(subdir.name,'.') && ~strcmp(subdir.name,'..')
        apply_recursively(fun, strcat(directory, '/', subdir.name), strcat(destination, '/', subdir.name));
    end
end