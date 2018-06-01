function [] = preprocess_FD_curves(source_directory, dest_directory)


mkdir(dest_directory);

allfiles = dir(source_directory);
subdirs = allfiles([allfiles.isdir]);
files = allfiles(~[allfiles.isdir]);% files that are not directories
filenames = {files(:).name};


for j = 1:length(filenames)
    filename = strcat(source_directory,'/',filenames{j})
    load(filename,'dist','force');
    
    %%% 1 - We remove all points from start phase
    breakpoint = length(dist);
    thresh = 20;
    for i = 1:length(dist)-3
        if force(i+3) - force(i) > thresh
            breakpoint = i+2;
            break
        end
    end
    for i = breakpoint:(length(dist)-10)
        if force(i) - force(i+10) > 0
            dist = dist(i:end);
            force = force(i:end);
            break
        end
    end
    
    %%% 2 - We remove all points from end phase
    min_points = 100;
    mu_f = mean(force(end-min_points:end));
    sigma_f = std(force(end-min_points:end));
    thresh = mu_f - 2.5*sigma_f;
    
    strikes = 0;
    max_strikes = 5;
    for i = length(force)-min_points:-1:1
        if force(i) < thresh
            strikes = strikes+1;
        else
            strikes = 0;
        end
        if strikes >= max_strikes
            
            dist = dist(1:i+max_strikes-1);
            force = force(1:i+max_strikes-1);
            break
        end
    end
    name = filenames{j};
    name = name(1:end-4); % cutting out ".txt"
    save(strcat(dest_directory,'/',name,'.mat'),'dist','force');
end

for i = 1:length(subdirs)
    subdir = subdirs(i);
    if ~strcmp(subdir.name,'.') && ~strcmp(subdir.name,'..')
        preprocess_FD_curves(strcat(directory, '/', subdir.name), strcat(destination, '/', subdir.name));
    end
end

end

