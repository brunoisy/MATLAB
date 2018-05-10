addpath('LSQ fit')
addpath('alignment')


directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);%18, 26, 95 -  44, 53 %[1:17,19:25,27:43,45:52,54:94,96:100]

% completeLc = [9,39,41,68,71,93,95,129,134,160,163,186,203,214,244,257,283,288,308,312,341,346,371,376,405,408]*.36;
% completeLc = [12,36,42,67,74,93,105,126,138,161,167,187,216,234,262,280,292,310,316,338,350,371,377,399]*.36;
% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

updLcs = cell(1,length(Lcs_lengths));
deltas = zeros(1,length(Lcs_lengths));
allLcs = [];

for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]%tracenumbers
    trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
    thisLc = Lcs{:,tracenumber};
    
    [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);
    load(trace,'dist','force')
    dist = dist+delta;
    [updLc,~,~,~,~] = LSQ_fit(dist, force, 4, 7, 10, 10, 5, 5);%permissive
    updLcs{tracenumber} = updLc;
    deltas(tracenumber) = delta;
    %     if ismember(tracenumber, [1:17,19:25,27:43,45:48,50:52,54:94,96:100])
    allLcs = [allLcs, updLc];
    %     end
end
allLcs = sort(allLcs);
save('finalLcs.mat','updLcs','deltas','allLcs')

%%
figure
hold on

ninlierss = [10, 20, 30, 40];
for j = 1:4
    subplot(2,2,j)
    allLcs = allLcs(allLcs<160);
    ninliers = ninlierss(j);
    N = length(allLcs)-ninliers+1;
    meanLc = zeros(1,N);
    varLc = zeros(1,N);
    for i = 1:N
        inliers = i:i+ninliers-1;
        meanLc(i) = mean(allLcs(inliers));
        varLc(i) = var(allLcs(inliers));
    end
    plot(meanLc, varLc,'LineWidth',2)
    %     title(strcat(["n = ", int2str(ninliers)]))
    title(['n = ',int2str(ninliers)])
    xlabel('window mean (nm)')
    ylabel('window var')
    set(gca,'FontSize',24)
end


% %%
% thresh = 2;
% mininliers = [55,55,50,30,30,20];
% npeaks = 6;
%
% remaining = true(1,length(allLcs));
% main_peaks = zeros(1, npeaks);
%
% for i = 1:npeaks
%     [peak, inliers] = ransac_peak(allLcs, remaining, thresh, mininliers(i));
%     i
%     length(inliers)
%     main_peaks(i) = peak;
%     remaining(inliers) = false;
% end
% %Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% main_peaks = sort(main_peaks)

%%
% xlimits = [0, 150];
% ylimits = [-300, 50];
% for tracenumber = tracenumbers
%     Lc = updLcs{tracenumber};
%     filteredLc = [];
%
%     for Lcj = main_peaks
%         if min(abs(Lc-Lcj)) < thresh
%             filteredLc = [filteredLc, Lcj];
%         end
%     end
%     %     for Lci = Lc
%     %         if min(abs(Lc-main_peaks
%     %         for Lcj = main_peaks
%     %             if abs(Lci-Lcj) < thresh
%     %                 filteredLc = [filteredLc, Lcj];%Lcj?
%     %             end
%     %         end
%     %     end
%
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     colors = get(gca, 'colororder');
%     hold on
%     set(gca,'FontSize',22)
%     xlim(xlimits);
%     ylim(ylimits);
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
%
%     trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
%     load(trace,'dist','force')
%     plot(dist+deltas(tracenumber), force, '.');
%
%     for i=1:length(filteredLc)
%         Xfit = linspace(0,filteredLc(i),1000);
%         Ffit = fd(filteredLc(i), Xfit);
%         plot(Xfit,Ffit,'Color','r');
%     end
%     saveas(gcf, strcat('images/peak counting/curve_',int2str(tracenumber),'.jpg'));
%     close
% end
%
% %%
% xlimits = [0, 150];
% ylimits = [-300, 50];
% for tracenumber = tracenumbers
%     Lc = updLcs{tracenumber};
%     Lc80 = 0;
%     for Lci = Lc
%         if(abs(Lci-80)<2)
%             Lc80 = Lci;
%         end
%     end
%     if min(abs(Lc-80)) < 2
%         figure('units','normalized','outerposition',[0 0 1 1]);
%         colors = get(gca, 'colororder');
%         hold on
%         set(gca,'FontSize',22)
%         xlim(xlimits);
%         ylim(ylimits);
%         xlabel('Distance (nm)');
%         ylabel('Force (pN)');
%
%         trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
%         load(trace,'dist','force')
%         plot(dist+deltas(tracenumber), force, '.');
%
%         for i=1:length(Lc)
%             Xfit = linspace(0,Lc(i),1000);
%             Ffit = fd(Lc(i), Xfit);
%             plot(Xfit,Ffit,'Color','r');
%         end
%         Xfit = linspace(0,Lc80,1000);
%         Ffit = fd(Lc80, Xfit);
%         plot(Xfit,Ffit,'Color','b');
%         saveas(gcf, strcat('images/plop/curve_',int2str(tracenumber),'.jpg'));
%         close
%     end
% end
