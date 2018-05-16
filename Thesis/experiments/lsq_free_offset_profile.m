filename = 'data/MAT_clean/data_4/curve_14.mat';%13
load(filename)
xlimits = [-10, 200];
ylimits = [-200, 50];


delta

[Lc, Xsel, Fsel, Xfirst, Xunfold,delta] = LSQ_fit_fd(dist, force, 4, false, 10, 10, 5);

figure
subplot(1,2,1)
hold on
xlim(xlimits);
ylim(ylimits);
set(gca,'FontSize',22)
title('WLC profile with fixed origin')
plot(dist, force,'.','markers',7);
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:),'LineWidth',2);
end



[Lc, Xsel, Fsel, Xfirst, Xunfold,delta] = LSQ_fit_fd(dist, force, 4, true, 10, 10, 5);
delta

subplot(1,2,2)
hold on
xlim(xlimits);
ylim(ylimits);
set(gca,'FontSize',22)
title('WLC profile with free offset')


plot(dist+delta, force,'.','markers',7);
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:),'LineWidth',2);
end

