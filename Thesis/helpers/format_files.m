directory = 'data_2/';% ../ not working, put back in main dir
%'../data_1/good/';
%'../data_1/bad/';

files = dir(directory);
files = files([files.isdir]==false);

filenames = {files(:).name};
for i = 1:length(filenames)
%     oldname = strcat(directory,filenames{i});
%     newname = strcat(directory,'curve_',int2str(i),'.txt');
%     movefile(oldname, newname);
    comma2point_overwrite(newname)% change commas to points
end