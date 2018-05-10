addpath('LSQ fit')
addpath('RANSAC fit')
rng(3)

xlimits = [0, 150];
ylimits = [-200, 50];

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:length(Lcs_lengths);%[1:43,45:52,54:100];
histogram(Lcs_lengths)
xlabel('length(P_{L_c})')
ylabel('# of WLC profiles')
set(gca,'FontSize',24)

%%
%%% clustering with RANSAC
% meanLcs = cell(1,4);
targetInlierRatio = [0.5,0.40,.60,.40];%[.20, .20, .05, .20];%
figure('units','normalized','outerposition',[0 0 1 1]);
hold on
colors = get(gca, 'colororder');
for n = 3:6%5%3:6%5
    for subcluster = 1%1:2 % number of subclusters to find
        if subcluster==1
            clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
        else
            outliers = true(1, sum(Lcs_lengths==n));
            outliers(inliers) = false;
            clusterLcs = clusterLcs(:,outliers); % potential inliers to this cluster must be outliers of previous cluster
        end
        %         [templateLc, inliers, deltas, MSE] = ransac_clustering_old(clusterLcs,@fittingfn_clustering,@distfn_clustering, 50, 0.1);
        [templateLc, inliers, deltas, MSE] = ransac_clustering(clusterLcs,@fittingfn_clustering,targetInlierRatio(subcluster,n-2));
        %%% Plotting
        %         subplot(1,2,subcluster)
        subplot(2,2,n-2)
        hold on
        set(gca,'FontSize',24)
        title(['k = ',num2str(n)])
        
        xlim(xlimits);
        ylim(ylimits);
        xlabel('Distance (nm)');
        ylabel('Force (pN)');
        for i=1:length(templateLc)
            Xfit = linspace(0,templateLc(i),1000);
            Ffit = fd(templateLc(i), Xfit);
            h = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
        end
        
        oktracenumbers = tracenumbers(Lcs_lengths == n);% select all traces with the right Lc length
        if subcluster ~=1
            oktracenumbers = oktracenumbers(outliers);
        end
        
        for i = 1:length(inliers)
            tracenumber = oktracenumbers(inliers(i));
            trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
            load(trace)
            plot(dist+deltas(i), force,'.','markers',7)
        end
%                 legend([h], {'WLC profile'})
        t = text(70,25,['inl. : ',num2str(length(inliers)), '/', num2str(length(clusterLcs)), ' = ', num2str(round(length(inliers)/length(clusterLcs)*100)), '%']);%num2str(inlierRatio)));
        t.FontSize = 24; 
        %         templateLcs{n-2} = templateLc;
        %         templateLc
    end
end

% % plot meanLcs
% figure
% subplot(1,2,1)
% hold on
% for n=3:6
%     templateLc = templateLcs{n-2};
%     plot(repmat(templateLc',2,1), [(7-n)*ones(1,length(templateLc));(7-n+1)*ones(1,length(templateLc))],'Color',colors(n-2,:))
% end
% xlabel('distance(nm)')
% set(gca,'ytick',[1.5, 2.5, 3.5, 4.5])
% set(gca,'YTickLabel',{'n=6','n=5','n=4','n=3'} );
% set(gca,'FontSize',22)
% title('mean cluster FD profiles')
%
% subplot(1,2,2)
% hold on
% meanLc6 = templateLcs{4};
% colors = get(gca, 'colororder');
% plot(repmat(templateLc',2,1), [ones(1,length(templateLc));2*ones(1,length(templateLc))],'Color',colors(4,:))
%
%
% for n=3:5
%     templateLc = templateLcs{n-2};
%     delta = mean(meanLc6(2:1+n)-templateLc)%     meanLc6([2:3,5:2+n])
%     plot(repmat(templateLc'+delta,2,1), [(7-n)*ones(1,length(templateLc));(7-n+1)*ones(1,length(templateLc))],'Color',colors(n-2,:))
%     text(3,7.6-n,'\rightarrow shift','fontsize',18)
%     plot(delta,(7.5-n),'*','Color',colors(n-2,:))
% end
% % legend('n = 3','n = 4','n = 5','n = 6')
% xlabel('distance(nm)')
% set(gca,'ytick',[1.5, 2.5, 3.5, 4.5])
% set(gca,'YTickLabel',{'n=6','n=5','n=4','n=3'} );
% set(gca,'FontSize',22)
% title('aligned mean cluster FD profiles')



