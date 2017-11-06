%directory = 'data/MAT/data_2/';
directory = 'data/MAT/data_1/good/';
%directory = 'data/MAT/data_1/bad/';

for filenumber = 1:9%[1,2,3,5,6,10,12,13,14,16,18]
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    fit_fd(filename,1,true)
    
    
    
end