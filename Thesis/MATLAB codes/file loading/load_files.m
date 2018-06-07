function [] = load_files(source_directory, dest_directory, numbered_curves)
% this function assumes all files in source_directory and its subdirectories
% are FD curves in ".txt" format. It loads those FD curves recursively,
% writing them into dest_directory in ".mat" format, using the same
% structure and names as the files from the source directory.
% if numbered_curves is true, then the files are renamed curve_1, curve_2...
% following the alphabetical order of the initial file names.


if nargin < 3
    numbered_curves = false;
end


mkdir(dest_directory)
allfiles = dir(source_directory);
subdirs = allfiles([allfiles.isdir]);
files = allfiles(~[allfiles.isdir]);% files that are not directories
filenames = {files(:).name};

for j = 1:length(filenames)
    filename = strcat(source_directory,'/',filenames{j})
    comma2point_overwrite(filename)
    
    fileID = fopen(filename);
    fgetl(fileID);
    Text = textscan(fileID, '%f %f');
    fclose(fileID);
    
    dist = Text{1}'; % distance in nm
    force = Text{2}'; % force in pN
    
    if numbered_curves
        save(strcat(dest_directory,'/curve_',int2str(j),'.mat'),'dist','force');
    else
        name = filenames{j};
        name = name(1:end-4); % cutting out ".txt"
        save(strcat(dest_directory,'/',name,'.mat'),'dist','force');
    end
end
end