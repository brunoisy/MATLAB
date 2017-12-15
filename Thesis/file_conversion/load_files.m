% subdirectory = 'LmrP single-NTA membrane/';
subdirectory = 'LmrP single-NTA nanodiscs/';

k = 0;
% subsubdirectories = {'tip1','tip2','tip3','tip4','tip5'};
subsubdirectories = {'tip1','tip2','tip3'};

for i = 1:length(subsubdirectories)
    subsubdirectory = subsubdirectories{i};
    directory = strcat('data/text/',subdirectory,subsubdirectory);
    
    files = dir(directory);
    files = files([files.isdir]==false);
    
    filenames = {files(:).name};
    for j =1:length(filenames)
        filename = strcat(directory,'/',filenames{j});
        k = k + 1;
        comma2point_overwrite(filename)
        
        fileID = fopen(filename);
        fgetl(fileID);
        Text = textscan(fileID, '%f %f');
        fclose(fileID);
        
        dist = Text{1}'; % distance in nm
        force = Text{2}'; % force in pN
%         save(strcat('data/MAT/data_3/curve_',int2str(k),'.mat'),'dist','force');
        save(strcat('data/MAT/data_4/curve_',int2str(k),'.mat'),'dist','force');
    end
end