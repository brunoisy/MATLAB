rng(3)

directory = 'data_4';%'LmrP Proteoliposomes';
load(strcat('data/FD profiles/',directory,'_old.mat'))

%%% clustering with RANSAC
prop_inliers = [.40, .40, .60, .40];
figure
hold on
colors = get(gca, 'colororder');

for n = 3:6
    Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
    
    [~, ~, deltas, ~] = ransac_clustering(Lcs_cluster,@fittingfn_clustering,prop_inliers(n-2));
    deltas = sort(deltas);
    %%% Plotting
    subplot(2,2,n-2)
    hold on
    set(gca,'FontSize',24)
    title(['k = ',int2str(n)])
    for delta = deltas
        plot([delta,delta],0:1, 'Color', colors(1,:),'LineWidth',2)
    end
    xlim([-25,30])
    ylim([0,1])

    if(n==5||n==6)
    xlabel('shift (nm)');
    end
    set(gca,'ytick',[])
end