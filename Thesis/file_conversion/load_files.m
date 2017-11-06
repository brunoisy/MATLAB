%subdirectory = 'data_2/';
% subdirectory = 'data_1/good/';
 subdirectory = 'data_1/bad/';

directory = strcat('data/text/',subdirectory);

files = dir(directory);
files = files([files.isdir]==false);

filenames = {files(:).name};
for i = 1:length(filenames)
    filename = strcat(directory,'curve_',int2str(i),'.txt');
    
    %         oldname = strcat(directory,filenames{i});
    %         movefile(oldname, filename);
    
    comma2point_overwrite(filename)% change commas to points
    
    
    fileID = fopen(filename);
    Text = textscan(fileID, '%f %f');
    fclose(fileID);
    
%     dist = Text{1}'; % distance in nm
%     force = Text{2}'; % force in pN
        dist = Text{1}'/10^6; % distance in nm
        force = Text{2}'/10^6; % force in pN
    save(strcat('data/MAT/',subdirectory,'curve_',int2str(i),'.mat'),'dist','force');
end