sec_peak = 77;%43.5;
plotn = 4;
startat = 28;

templateLc = [34.4800,   54.5995,   92.3607,  118.0434,  140.5817];
xlimits = [0, 130];
ylimits = [-180, 50];

minDiff = zeros(1,100);
for tracenumber = 1:100
    Lc = exhLcs{tracenumber};
    if npeaks(tracenumber) >1
        minDiff(tracenumber) = min(abs(Lc-sec_peak));
    else
        minDiff(tracenumber) = Inf;
    end
end

[~, I] = sort(minDiff);
figure('units','normalized','outerposition',[0 0 1 1]);
colors = get(gca, 'colororder');


for j=1:plotn
    tracenumber = I(j+startat);
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace)
    
    subplot(plotn/2,2,j)
    hold on
    set(gca,'FontSize',24)
    title(['FD curve ', int2str(tracenumber)])
    xlim(xlimits);
    ylim(ylimits);
    
    
    plot(dist+deltas(tracenumber),force,'.');
    
    for i=1:length(templateLc)
        Xfit = linspace(0,templateLc(i),1000);
        Ffit = fd(templateLc(i), Xfit);
        h1 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
    end
    
    Xfit = linspace(0,sec_peak,1000);
    Ffit = fd(sec_peak, Xfit);
    h2 = plot(Xfit,Ffit,'Color',colors(5,:),'LineWidth',2);
    if j==1 || j==3
        ylabel('Force (pN)');
    end
    if j==3||j==4
            xlabel('Distance (nm)');
    end
    %     legend([h1,h2],{'main WLC profile', 'WLC curve L_c = 43.5'})
    %     saveas(gcf, strcat('images/peak1_curves/curve_',int2str(tracenumber),'.jpg'));
    %     close
end
