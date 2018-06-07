addpath('LSQ fit')
addpath('RANSAC fit')
rng(3)

xlimits = [0, 150];
ylimits = [-200, 50];

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'_old.mat'),'Lcs','Lcs_lengths')
tracenumbers = 1:100;%[1:43,45:52,54:100];%-33
% histogram(Lcs_lengths(tracenumbers))
% xlabel('length(P_{Lc})')
% ylabel('# of WLC profiles')
% set(gca,'FontSize',24)

%%
%%% clustering with RANSAC
% meanLcs = cell(1,4);
targetInlierRatio = [1,1,1,1]%[0.40,0.40,.60,.40; 0.1,0.1,0.2,0.2];%[.20, .20, .05, .20];%
figure('units','normalized','outerposition',[0 0 1 1]);
hold on
set(gca,'FontSize',24)
colors = get(gca, 'colororder');
for n = 3:6
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
        %                 subplot(1,2,subcluster)
        %         if subcluster==2
        %             subplot(2,2,n-2)
        %             hold on
        %
        %
        %             set(gca,'FontSize',24)
        %             title(['k = ',num2str(n)])
        %
        %             xlim(xlimits);
        %             ylim(ylimits);
        %
        %
        %             for i=1:length(templateLc)
        %                 Xfit = linspace(0,templateLc(i),1000);
        %                 Ffit = fd(templateLc(i), Xfit);
        %                 h = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
        %             end
        %
        %             oktracenumbers = tracenumbers(Lcs_lengths == n);% select all traces with the right Lc length
        %             if subcluster ~=1
        %                 oktracenumbers = oktracenumbers(outliers);
        %             end
        %
        %             for i = 1:length(inliers)
        %                 tracenumber = oktracenumbers(inliers(i));
        %                 trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        %                 load(trace);
        %
        %                 plot(dist+deltas(i), force,'.','markers',5,'Color',colors(mod(i+2,7)+1,:))
        %                 %                 plot(dist+deltas(i), force,'.','markers',5)
        %
        %             end
        %             %                 legend([h], {'WLC profile'})
        %             t = text(70,25,['inl. : ',num2str(length(inliers)), '/', num2str(length(clusterLcs)), ' = ', num2str(round(length(inliers)/length(clusterLcs)*100)), '%']);%num2str(inlierRatio)));
        %             t.FontSize = 24;
        %         end
        subplot(2,2,n-2)
        hold on
        set(gca,'FontSize',24)
        
        title(['k = ',num2str(n)])
        
        
        clusterLcs2 = clusterLcs(:,inliers);
        for j = 1:length(clusterLcs2(1,:))
            Lc = clusterLcs2(:,j);
            [delta,~,~] = align(templateLc, Lc);
            Lc = Lc+delta;
            for i = 1:length(Lc)
                Xfit = linspace(0,Lc(i),1000);
                Ffit = fd(Lc(i), Xfit);
                h1 = plot(Xfit,Ffit,'Color',colors(1,:),'LineWidth',1);
            end
        end
        
        for i=1:length(templateLc)
            Xfit = linspace(0,templateLc(i),1000);
            Ffit = fd(templateLc(i), Xfit);
            h2 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
        end
        
        %     lgd = legend([h2, h1], {'mean WLC profile','aligned WLC profiles'});
        %     lgd.FontSize = 18;
        
        
        
        
        
        if n==5 || n==6
            xlabel('Distance (nm)');
        end
        if n==3 || n==5
            ylabel('Force (pN)');
        end
        xlim(xlimits);
        ylim(ylimits);
    end
end




