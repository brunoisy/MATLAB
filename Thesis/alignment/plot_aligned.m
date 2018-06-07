
% % default limits
xlimits = [-10, 150];
ylimits = [-200, 50];%[-250, 50];


subdir = 'data_4/';
tracenumbers = 1:100; %1:10%1:119;
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];


dir = strcat('data/MAT_clean/',subdir);



for tracenumber = 15%[1:43,45:52,54:100]
    trace = strcat(dir,'curve_',int2str(tracenumber),'.mat');
    load(trace)
    deltas(tracenumber)
    dist = dist+deltas(tracenumber);
    
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    colors = get(gca, 'colororder');
    hold on
    title('aligned FD curve')
    set(gca,'FontSize',24)
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    
    
    plot(dist,force,'.','markers',12)
    for j=1:length(templateLc)
        Xfit = linspace(0,templateLc(j),1000);
        Ffit = fd(templateLc(j), Xfit);
        templateh = plot(Xfit,Ffit,'Color',colors(2,:),'LineWidth',3);
    end
    updLc1 = exhLcs{tracenumber};
    for j=1:length(updLc1)
        Xfit = linspace(0,updLc1(j),1000);
        Ffit = fd(updLc1(j), Xfit);
        Lch = plot(Xfit,Ffit,'Color',colors(1,:),'LineWidth',2);
    end
%     if npeaks(tracenumber) <= 1
%         saveas(gcf, strcat('images/alignment_exhaustive2/misaligned/curve_',int2str(tracenumber),'.jpg'));
%     else
%         saveas(gcf, strcat('images/alignment_exhaustive2/aligned/curve_',int2str(tracenumber),'.jpg'));
%     end
%     close
end