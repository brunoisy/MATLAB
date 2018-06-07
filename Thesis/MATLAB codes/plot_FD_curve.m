function [] = plot_FD_curve(filename, destname)
%PLOT_FD_CURVE Summary of this function goes here
%   Detailed explanation goes here


load(filename,'dist','force');


figure('units','normalized','outerposition',[0 0 1 1]);
colors = get(gca, 'colororder');

hold on
set(gca,'FontSize',24)
% xlim(xlimits);
% ylim(ylimits);
plot(dist,force,'.','markers',12);

saveas(gcf,destname)
close
end

