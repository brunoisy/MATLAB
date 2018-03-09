addpath('LSQ fit')
addpath('RANSAC fit')

rng(3)

directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'))

%%% clustering with RANSAC
n = 5;
Lcs_cluster = cell2mat(Lcs(Lcs_lengths == n)')';
props_inliers = (1:length(Lcs_cluster(1,:)))/length(Lcs_cluster(1,:));

ninliers = zeros(1,length(Lcs_cluster(1,:)));
variance = zeros(1,length(Lcs_cluster(1,:)));

thresh = 100;

for i = 1:length(Lcs_cluster(1,:))
    prop_inliers = props_inliers(i);
    [~, ~, ~, MSE] = ransac_clustering2(Lcs_cluster,@fittingfn_clustering,@distfn_clustering,thresh, prop_inliers, true);
    variance(i) = MSE;
end
figure
hold on
plot(props_inliers,variance);
xlabel('proportion of inliers to the model');
ylabel('variance of inliers w.r.t model')