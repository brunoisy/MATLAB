rng(3)

directory = 'data_4';%'LmrP Proteoliposomes';
load(strcat('data/FD profiles/',directory,'.mat'))

%%% clustering with RANSAC
prop_inliers = [.50, .40, .60, .40];
figure
hold on
colors = get(gca, 'colororder');
for n = 3:6%5%3:6
    Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
    
    [~, ~, deltas, ~] = ransac_clustering2(Lcs_cluster,@fittingfn_clustering,prop_inliers(n-2));
    deltas = sort(deltas);
    %%% Plotting
    subplot(2,2,n-2)
    hold on
    set(gca,'FontSize',22)
    title(strcat('distribution of deltas for n = ',int2str(n)))
    for delta = deltas
        plot([delta,delta],0:1)
    end
    ylim([0,1])
    xlabel('delta');
    set(gca,'ytick',[])
    
end
