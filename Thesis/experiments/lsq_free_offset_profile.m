filename = 'data/MAT_clean/data_4/curve_5.mat';
load(filename)
xlimits = [-10, 150];
ylimits = [-200, 50];



[Lc, Xsel, Fsel, Xfirst, Xunfold,delta] = LSQ_fit_fd(dist, force, 4, false, 10, 10, 5);

figure
colors = get(gca, 'colororder');

subplot(1,2,1)
hold on
xlim(xlimits);
ylim(ylimits);
set(gca,'FontSize',22)
title('WLC profile with fixed origin')
plot(dist, force,'.','markers',12);
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:),'LineWidth',2);
end
for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y = Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    
    plot(X,Y,'.','Color',colors(mod(i,6)+1,:),'markers',12)
end


[Lc, Xsel, Fsel, Xfirst, Xunfold,delta] = LSQ_fit_fd(dist, force, 4, true, 10, 10, 5);
delta

subplot(1,2,2)
hold on
xlim(xlimits);
ylim(ylimits);
set(gca,'FontSize',22)
title('WLC profile with free offset')


plot(dist+delta, force,'.','markers',12);
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit,Ffit,'Color',colors(mod(i,7)+1,:),'LineWidth',2);
end
for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y = Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    
    plot(X+delta,Y,'.','Color',colors(mod(i,6)+1,:),'markers',12)
end

