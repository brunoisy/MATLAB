addpath('LSQ fit')

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);
xlimits = [0, 150];
ylimits = [-200, 50];
% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];



for n = 2:7
    %     mkdir(strcat('images/retro fitting/exhaustive/n_',int2str(n)))
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1:length(clusterLcs(1,:))
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
        if tracenumber == 15
            
            trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
            thisLc = clusterLcs(:,i)';
            
            [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
            load(trace,'dist','force')
            
            [updLc1,~,~,~,~] =  LSQ_fit(dist+delta, force, 4, 7, 10, 10, 5, 5);
            
            
            figure('units','normalized','outerposition',[0 0 1 1]);
            colors = get(gca, 'colororder');
            hold on
            title('aligned FD curve')
            set(gca,'FontSize',24)
            xlim(xlimits);
            ylim(ylimits);
            xlabel('Distance (nm)');
            ylabel('Force (pN)');
            
            for j=1:length(templateLc)
                Xfit = linspace(0,templateLc(j),1000);
                Ffit = fd(templateLc(j), Xfit);
                templateh = plot(Xfit,Ffit,'Color',colors(2,:),'LineWidth',3);
            end
            
            
            plot(dist+delta, force,'.','Color',colors(1,:),'markers',12)
            for j=1:length(updLc1)
                Xfit = linspace(0,updLc1(j),1000);
                Ffit = fd(updLc1(j), Xfit);
                Lch = plot(Xfit,Ffit,'Color',colors(1,:),'LineWidth',2);
            end
            
            lgd = legend([templateh,Lch],'template WLC profile','curve WLC profile');
            set(gca,'FontSize',24)
            lgd.FontSize = 30;
            %         if npeaks >1
            %             saveas(gcf, strcat('images/alignment/aligned/curve_',int2str(tracenumber),'.jpg'));
            %         else
            %             saveas(gcf, strcat('images/alignment/misaligned/curve_',int2str(tracenumber),'.jpg'));
            %         end
            %         close
        end
    end
end
