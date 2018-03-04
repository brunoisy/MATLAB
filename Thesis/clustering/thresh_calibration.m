addpath('LSQ fit')
addpath('RANSAC fit')

xlimits = [0, 150];
ylimits = [-300, 50];

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))
tracenumbers = 1:length(Lcs_lengths(1,:));
% histogram(Lcs_lengths)

%%% clustering with RANSAC
n = 5;
Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';

threshs = 15:25:1000;%15:20:200%
ninliers = zeros(1,length(threshs));
variance = zeros(1,length(threshs));
for i = 1:length(threshs)
    thresh = threshs(i);
    [~, inliers, ~, MSE] = ransac_clustering(Lcs_cluster,@fittingfn_clustering,@distfn_clustering,3,thresh, 0.20, true,100);
    ninliers(i) = length(inliers);
    variance(i) = MSE;
end
figure
hold on
plot(threshs,ninliers);
plot(threshs,variance);
legend('ninliers','variance');
xlabel('TSE threshold');