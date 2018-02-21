directory = 'data/MAT_clean/data_4/';
filenumbers = 136:271;

load('constants.mat')
addpath('functions')
addpath('functions_ransac')

xlimits = [-10, 150];
ylimits = [-250, 50];

Lc = cell(1, length(filenumbers));
lengthLc = zeros(1,length(filenumbers));
for i = 1:length(filenumbers)
    filename = strcat(directory,'curve_',int2str(filenumbers(i)),'.mat')
    load(filename);
    [Lci, ~, ~, ~, ~] = LSQ_fit_fd(dist,force);
    Lc{i} = Lci;
    lengthLc(i) = length(Lci);
end
figure
histogram(lengthLc);




