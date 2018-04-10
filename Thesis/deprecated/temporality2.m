load('data/MAT/data_4/curve_3.mat');

figure
hold on
xlimits = [-10, 200];
ylimits = [-150, 200];
xlim(xlimits);
ylim(ylimits);
plot(dist,force,'.b')


for i = 1:length(dist)
    if i > 20
        plot(dist(i-20), force(i-20),'.b')
        pause(0.025)
    end
    plot(dist(i), force(i),'.r');
end