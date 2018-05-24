sec_peak = 77;
plotn = 10;

templateLc = [34.4800,   54.5995,   92.3607,  118.0434,  140.5817];
xlimits = [-10, 150];
ylimits = [-200, 50];

minDiff = zeros(1,100);
for tracenumber = 1:100
    Lc = exhLcs{tracenumber};
    minDiff(tracenumber) = min(abs(Lc-sec_peak));
end

[~, I] = sort(minDiff);
for tracenumber = I(1:plotn)
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace)
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    hold on
    colors = get(gca, 'colororder');
    
    xlim(xlimits);
    ylim(ylimits);
    
    plot(dist+deltas(tracenumber),force,'.');
    
    for i=1:length(templateLc)
        Xfit = linspace(0,templateLc(i),1000);
        Ffit = fd(templateLc(i), Xfit);
        h2 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
    end
    
    Xfit = linspace(0,sec_peak,1000);
    Ffit = fd(sec_peak, Xfit);
    plot(Xfit,Ffit,'Color',colors(5,:),'LineWidth',2);
    saveas(gcf, strcat('images/peak2_curves/curve_',int2str(tracenumber),'.jpg'));
    close
end
