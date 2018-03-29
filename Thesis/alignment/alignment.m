addpath('LSQ fit')

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))
tracenumbers = 1:length(Lcs_lengths);
xlimits = [0, 150];
ylimits = [-300, 50];

templateLc = [36, 59, 99, 124, 148]; % check accuracy with melanie! shift? precision?
templateSeq = to_sequence(templateLc);
% this is the templateLc found for the main cluster in data4


for n = 3%2:8
    mkdir(strcat('images/retro fitting/',directory,'/n_',int2str(n)))
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1%1:length(clusterLcs(1,:));
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
        trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        thisLc = clusterLcs(:,i);
        
%         totalDelta1 = 0;
%         updLc1 = thisLc;
%         for it = 1:3
%             delta = minLSQ_align(templateLc,updLc1);
%             totalDelta1 = totalDelta1+delta;
%             load(trace)
%             dist = dist+totalDelta1;
%             [updLc1,~,~,~,~] = LSQ_fit_fd(dist, force); 
%             updLc1 = updLc1';
%         end
        
        totalDelta2 = 0;
        updLc2 = thisLc;
        scoreMatrix = [1,-1,0,0;-1,10,0,0;0,0,0,0;0,0,0,0;];
        for it = 1%1:3
            thisSeq = to_sequence(updLc2);
%             [score, alignment1, aligner, alignment2] = needleman_wunsch(templateSeq, thisSeq, 1,7, -10, -1);
            [score, alignment, startat] = nwalign(templateSeq, thisSeq,'Alphabet', 'NT','ScoringMatrix',scoreMatrix,'GapOpen',10,  )
            totalDelta2 = totalDelta2 + find(aligner,1)*0.36%use alignment method here
%             load(trace)
%             dist = dist+totalDelta2;
%             [updLc2,~,~,~,~] = LSQ_fit_fd(dist, force); 
%             updLc2 = updLc2';
        end
        figure,
%         subplot(1,2,1)
%         hold on
%         title('minLSQ alignment')
%         set(gca,'FontSize',22)
%         xlim(xlimits);
%         ylim(ylimits);
%         
%         for j=1:length(templateLc)
%             Xfit = linspace(0,templateLc(j),1000);
%             Ffit = fd(templateLc(j), Xfit);
%             templateh = plot(Xfit,Ffit,'Color','r');
%         end
%         
%         load(trace)
%         plot(dist+totalDelta1, force,'.')
%         for j=1:length(updLc1)
%             Xfit = linspace(0,updLc1(j),1000);
%             Ffit = fd(updLc1(j), Xfit);
%             Lch = plot(Xfit,Ffit,'Color','b');
%         end
        
%         legend([templateh,Lch],'template FD profile','trace FD profile')
        %%%%%%%
        subplot(1,2,2)
        hold on
        title('sequence alignment')
        set(gca,'FontSize',22)
        xlim(xlimits);
        ylim(ylimits);
        for j=1:length(templateLc)
            Xfit = linspace(0,templateLc(j),1000);
            Ffit = fd(templateLc(j), Xfit);
            templateh = plot(Xfit,Ffit,'Color','r');
        end
        
        load(trace)
        plot(dist+totalDelta2, force,'.')
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