addpath('LSQ fit')
addpath('RANSAC fit')

rng(3)

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))

%%% clustering with RANSAC
figure
hold on
for n = 3:6
    Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
    inlier_ratios = (1:length(Lcs_cluster(1,:)))/length(Lcs_cluster(1,:));
    
    ninliers = zeros(1,length(Lcs_cluster(1,:)));
    variance = zeros(1,length(Lcs_cluster(1,:)));
    
    for i = 1:length(Lcs_cluster(1,:))
        inlier_ratio = inlier_ratios(i);
        [~, ~, ~, MSE] = ransac_clustering(Lcs_cluster,@fittingfn_clustering, inlier_ratio);
        variance(i) = MSE;
    end
    subplot(2,2,n-2)
    hold on
    set(gca,'FontSize',24)
    title(['k = ',int2str(n)])
    plot(inlier_ratios,variance,'LineWidth',2);
    xlabel('inlier ratio');
    ylabel('variance of inliers');
    ylim([0,300]);
end