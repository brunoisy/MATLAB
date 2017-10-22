directory = 'data/MAT/data_2/';
%directory = 'data/MAT/data_1/good/';
%directory = 'data/MAT/data_1/bad/';

for filenumber = 1:10
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    %%%% ...
end