function [] = load_file(filename, destination, name)
%LOAD_FILE Summary of this function goes here
%   Detailed explanation goes here
if strcmp(filename(end-2:end), 'txt')
    comma2point_overwrite(filename)
    
    fileID = fopen(filename);
    fgetl(fileID);
    Text = textscan(fileID, '%f %f');
    fclose(fileID);
    
    dist = Text{1}'; % distance in nm
    force = Text{2}'; % force in pN
    
    % name = filenames{j};
    save(strcat(destination,'/',name,'.mat'),'dist','force');
end
end

