directory = 'data_2/';
%'../data_1/good/';
%'../data_1/bad/';

files = dir(directory);
files = files([files.isdir]==false);

filenames = {files(:).name};
for i = 1:length(filenames)
%     oldname = strcat(directory,filenames{i});
%     newname = strcat(directory,'curve_',int2str(i),'.txt');
%     movefile(oldname, newname);
    comma2point_overwrite(filenames{i})% change commas to points
end