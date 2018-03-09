function [] = plot_trace(trace, destination, name)
%PLOT_TRACE Summary of this function goes here
%   Detailed explanation goes here
xlimits = [-10, 200];
ylimits = [-400, 50];

load(trace)
%%% Plot the initial points
figure
hold on
title('Initial Trace');

xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
plot(dist, force,'.')

%%% Save Plot
saveas(gcf, strcat(destination,'/',name,'.jpg'));
close

end

