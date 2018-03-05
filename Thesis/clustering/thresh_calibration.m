addpath('LSQ fit')
addpath('RANSAC fit')

xlimits = [0, 150];
ylimits = [-300, 50];
rng(3)

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))

%%% clustering with RANSAC
n = 3;
Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';

threshs = 15:50:2000;%15:20:200%
ninliers = zeros(1,length(threshs));
variance = zeros(1,length(threshs));
for i = 1:length(threshs)
    thresh = threshs(i);
    [~, inliers, ~, MSE] = ransac_clustering(Lcs_cluster,@fittingfn_clustering,@distfn_clustering,thresh, 0.20, true);
    ninliers(i) = length(inliers);
    variance(i) = MSE;
end
figure
hold on
plot(threshs,ninliers);
plot(threshs,variance);
legend('ninliers','variance');
xlabel('TSE threshold');