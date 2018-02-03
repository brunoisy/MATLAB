dir = 'data/MAT_clean/data_2/';
file = 'curve_1.mat';

xlimits = [-10, 180];
ylimits = [-150, 100];

load(strcat(dir,file))

figure
hold on
title('Cleaned FD trace')
plot(dist,force,'.')

xlim(xlimits)
ylim(ylimits)
xlabel('Distance (nm)');
ylabel('Force (pN)');

set(gca,'FontSize',22)
