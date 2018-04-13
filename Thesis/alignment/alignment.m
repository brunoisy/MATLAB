addpath('LSQ fit')

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);
xlimits = [0, 150];
ylimits = [-300, 50];
% completeLc = [9,39,41,68,71,93,95,129,134,160,163,186,203,214,244,257,283,288,308,312,341,346,371,376,405,408]*.36;
% completeLc = [12,36,42,67,74,93,105,126,138,161,167,187,216,234,262,280,292,310,316,338,350,371,377,399]*.36;
% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];



for n = 2:8
    %     mkdir(strcat('images/retro fitting/exhaustive/n_',int2str(n)))
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1:length(clusterLcs(1,:))
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
        %                         if tracenumber == 12
        
        trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        thisLc = clusterLcs(:,i)';
        
        [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
        load(trace,'dist','force')
        
        [updLc1,~,~,~,~] = LSQ_fit_fd(dist+delta, force);
        
        
        figure('units','normalized','outerposition',[0 0 1 1]);
        colors = get(gca, 'colororder');
        hold on
        title('exhaustive alignment')
        set(gca,'FontSize',22)
        xlim(xlimits);
        ylim(ylimits);
        xlabel('Distance (nm)');
        ylabel('Force (pN)');
        
        for j=1:length(templateLc)
            Xfit = linspace(0,templateLc(j),1000);
            Ffit = fd(templateLc(j), Xfit);
            templateh = plot(Xfit,Ffit,'Color','r');
        end
        
        
        plot(dist+delta, force,'.','Color','b')
        for j=1:length(updLc1)
            Xfit = linspace(0,updLc1(j),1000);
            Ffit = fd(updLc1(j), Xfit);
            Lch = plot(Xfit,Ffit,'Color','b');
        end
        
        legend([templateh,Lch],'template FD profile','trace FD profile')
        
        if npeaks >1
            saveas(gcf, strcat('images/retro fitting/exhaustive/aligned/curve_',int2str(tracenumber),'.jpg'));
        else
            saveas(gcf, strcat('images/retro fitting/exhaustive/misaligned/curve_',int2str(tracenumber),'.jpg'));            
        end
        close
        %             end
    end
end