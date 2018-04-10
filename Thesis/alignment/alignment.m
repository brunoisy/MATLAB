addpath('LSQ fit')

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))
tracenumbers = 1:length(Lcs_lengths);
xlimits = [0, 150];
ylimits = [-300, 50];
% completeLc = [9,39,41,68,71,93,95,129,134,160,163,186,203,214,244,257,283,288,308,312,341,346,371,376,405,408]*.36;
completeLc = [12,36,42,67,74,93,105,126,138,161,167,187,216,234,262,280,292,310,316,338,350,371,377,399]*.36;
templateLc = [93, 161, 262, 338, 399]*.36;%[36, 59, 99, 124, 148]; % check accuracy with melanie! shift? precision?

templateSeq = to_sequence(templateLc);
% this is the templateLc found for the main cluster in data4


for n = 2:8
    mkdir(strcat('images/retro fitting/',directory,'/n_',int2str(n)))
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1:length(clusterLcs(1,:))
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
        if tracenumber == 97
            
            trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
            thisLc = clusterLcs(:,i)';
            
            totalDelta1 = 0;
            updLc1 = thisLc;
            for it = 1:5
                delta = minLSQ_align(templateLc,updLc1);
                totalDelta1 = totalDelta1+delta;
                load(trace)
                dist = dist+totalDelta1;
                [updLc1,~,~,~,~] = LSQ_fit_fd(dist, force);
            end
            
            totalDelta2 = 0;
            updLc2 = thisLc;
            scoreMatrix = [1,-100,0,0;-100,27,0,0;0,0,0,0;0,0,0,0];
            for it = 1:5
                thisSeq = to_sequence(updLc2);
                [score, aligner, start] = nwalign(templateSeq, thisSeq,'Alphabet', 'NT','ScoringMatrix',scoreMatrix,'GapOpen',1,'ExtendGap',1,'Glocal',true);
                
                aligner1 = aligner(1,:);
                aligner2 = aligner(2,:);
                delta = find(aligner2=='|',1)*0.36;
                if aligner1(1) == '-'
                    totalDelta2 = totalDelta2 - delta;
                else
                    totalDelta2 = totalDelta2 + delta;
                end
                %                         updLc2 = updLc2+totalDelta2;
                if it < 5
                    load(trace)
                    dist = dist+totalDelta2;
                    [updLc2,~,~,~,~] = LSQ_fit_fd(dist, force);
                else
                    if aligner1(1) == '-'
                        updLc2 = updLc2-delta;
                    else
                        updLc2 = updLc2+delta;
                    end
                    updLc2 = updLc2+delta;
                end
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            figure('units','normalized','outerposition',[0 0 1 1]);
            colors = get(gca, 'colororder');
            
            subplot(1,2,1)
            hold on
            title('minLSQ alignment')
            set(gca,'FontSize',22)
            xlim(xlimits);
            ylim(ylimits);
            xlabel('Distance (nm)');
            ylabel('Force (pN)');
            
            for j=1:length(completeLc)
                Xfit = linspace(0,completeLc(j),1000);
                Ffit = fd(completeLc(j), Xfit);
                templateh = plot(Xfit,Ffit,'Color','r');
            end
            
            load(trace)
            plot(dist+totalDelta1, force,'.','Color','b')
            for j=1:length(updLc1)
                Xfit = linspace(0,updLc1(j),1000);
                Ffit = fd(updLc1(j), Xfit);
                Lch = plot(Xfit,Ffit,'Color','b');
            end
            
            legend([templateh,Lch],'template FD profile','trace FD profile')
            
            %%%%%%%
            subplot(1,2,2)
            hold on
            title('sequence alignment')
            set(gca,'FontSize',22)
            xlim(xlimits);
            ylim(ylimits);
            xlabel('Distance (nm)');
            ylabel('Force (pN)');
            for j=1:length(completeLc)
                Xfit = linspace(0,completeLc(j),1000);
                Ffit = fd(completeLc(j), Xfit);
                templateh = plot(Xfit,Ffit,'Color','r');
            end
            
            load(trace)
            plot(dist+totalDelta2, force,'.','Color', 'b')
            for j=1:length(updLc2)
                Xfit = linspace(0,updLc2(j),1000);
                Ffit = fd(updLc2(j), Xfit);
                Lch = plot(Xfit,Ffit,'Color','b');
            end
            
            legend([templateh,Lch],'template FD profile','trace FD profile')
            
            %         saveas(gcf, strcat('images/retro fitting/',directory,'/n_',int2str(n),'/curve_',int2str(tracenumber),'.jpg'));
            %         close
        end
    end
end