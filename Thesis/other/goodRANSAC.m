addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_1.mat';
%filename = 'data/MAT/data_1/good/curve_2.mat';

load(filename)
x = [dist; force];
labels = zeros(1,length(x)); % labels of the different points (zero if unlabeled)


%%% 1 - We fit a first line to the profile, to get rid of approaching phase
thresh = 8;
[~, inliers] = ransac(x(:,labels == 0), @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 10, 200, true);
newlabels = zeros(1, sum(labels == 0));
newlabels(inliers) = ones(1, length(inliers));
labels(labels == 0) = newlabels;

%%% 1 - We fit a horizontal line to the last points, to get rid of end
%%% noise
thresh = 20;
[~, inliers] = ransac(x(:,labels == 0), @linefittingfn, @linedistfn_2, @degenfn, 5, thresh, 1, 10, 200, false, true);
newlabels = zeros(1, sum(labels == 0));
newlabels(inliers) = 2*ones(1, length(inliers));
labels(labels == 0) = newlabels;


%%% 3 - We attempt to fit an FD curve to the different crests
Lc = zeros(1,10);
ncrest = 0;
thresh = 20;
while ncrest < 10
    if ~any(labels == 0)
        break
    end
    [~,inliers] = ransac(x(:,labels == 0), @fittingfn, @distfn, @degenfn, 1, thresh, 1, 10, 200);
    if isempty(inliers)
        break
    elseif length(inliers) < 10
        newlabels = zeros(1, sum(labels == 0));
        newlabels(inliers) = -ones(1, length(inliers));% i.e., these points are discarded
        labels(labels == 0) = newlabels;
    else   
        newlabels = zeros(1, sum(labels == 0));
        newlabels(inliers) = (3+ncrest)*ones(1, length(inliers));
        labels(labels == 0) = newlabels;
        
        Lc(ncrest+1) = fittingfn(x(:,labels == 3+ncrest));
        ncrest = ncrest+1;
    end
end







%%%% Plot
xlimits = [-10, 200];
ylimits = [-150, 200];

figure
subplot(1,2,1)
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('initial datapoints');
plot(x(1,:), x(2,:),'.')



subplot(1,2,2)
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('Approximated FD curves using RANSAC');


inliers = x(:,labels == 1);
plot(inliers(1,:), inliers(2,:),'.')
ab = polyfit(inliers(1,:), inliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(inliers(1,:)'),max(inliers(1,:)'));
F = a*X+b;
plot(X,F)



inliers = x(:,labels == 2);
plot(inliers(1,:), inliers(2,:),'.')
ab = polyfit(inliers(1,:), inliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(inliers(1,:)'),max(inliers(1,:)'));
F = a*X+b;
plot(X,F)



for i = 1:ncrest
    inliers = x(:,labels == i+2);
    plot(inliers(1,:), inliers(2,:),'.')
    
    X = linspace(0,Lc(i));
    F = fd(Lc(i), X);
    plot(X,F)
end
