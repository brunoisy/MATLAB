%%% generate the data
rng(3)

sigmaY1 = 1.5;

X1 = linspace(-10,10,100);
Y1 = randn(1,100)*sigmaY1;

figure
hold on
plot(X1,Y1,'.')

theta = 1;
sigmaY2 = 0.5;
X2 = linspace(-10,10,100);
Y2 = randn(1,100)*sigmaY2;

X3 = sin(theta)*X2+cos(theta)*Y2;
Y3 = -sin(theta)*X2+cos(theta)*Y2;
plot(X3,Y3,'.')
% xlim(7*[-1,1])
% ylim(7*[-1,1])


%%% Analyze
n = 200; %number of data points
variance = zeros(1,n);
for i = 1:200
    [~, ~, ~, MSE] = ransac_line(Lcs_cluster,@fittingfn_clustering, prop_inliers);
    variance(i) = MSE;
end
figure
hold on
set(gca,'FontSize',22)
plot(linspace(0,1,200),variance);
xlabel('proportion of inliers to the model');
ylabel('variance of inliers');
