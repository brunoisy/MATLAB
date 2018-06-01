subdir = 'data_4/';
dir = strcat('data/MAT_clean/',subdir);
tracenumbers = 1:100;


xlimits = [-10, 200];
ylimits = [-250, 50];

figure
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
for tracenumber = [ 5     9    12    22    37    51    54    69    82]%tracenumbers
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
    
    plot(dist+deltas(tracenumber), force,'.','Color','b') 
end