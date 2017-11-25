load('data/MAT/data_2/curve_1.mat');

figure
hold on
xlimits = [-10, 200];
ylimits = [-150, 200];
xlim(xlimits);
ylim(ylimits);
colors = ['.y', '.m', '.c', '.r', '.g','.b','.k'];
for i = 1:length(dist)
    plot(dist(i), force(i), colors(mod(i, 7)+1))
end
