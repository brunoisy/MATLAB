addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_1.mat';
%filename = 'data/MAT/data_1/good/curve_2.mat';

load(filename)
x = [dist; force];
labels = zeros(1,length(x)); % labels of the different points (zero if unlabeled), -1 if first line, -2 if discarded, 1+ if labeled


%%% 1 - We fit a first line to the profile, to get rid of approaching phase
thresh = 8;
[~, inliers] = ransac(x(:,labels == 0), @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 10, 200, true);
labels = update_labels(labels, inliers, -1);

outliers = 1:length(x);
outliers = outliers(x(1,inliers(end)) < x(1,:) & x(1,:) < x(1,inliers(end)) + 15)-inliers(end);
if ~isempty(outliers)
    labels = update_labels(labels, outliers, -2); % we discard all outliers between peak and peak + thresh
end


%%% 2 - We attempt to fit an FD curve to the different crests
Lc = zeros(1,10);
maxLc = 200;

thresh = 5;
for i = 1:1
    if ~any(labels == 0)
        ncrest = i-1;
        break
    end
    [~,inliers] = ransac_2(x(:,labels == 0), @fittingfn, @distfn_2, @degenfn, 1, thresh, 1, 10, 200);
    labels = update_labels(labels, inliers, i);
    
    outliers = 1:length(x);
    outliers = outliers(x(1,inliers(end)) < x(1,:) & x(1,:) < x(1,inliers(end)) + thresh)-inliers(end);
    if ~isempty(outliers)
        labels = update_labels(labels, outliers, -2); % we discard all outliers between peak and peak + thresh
    end
    
    Lc(i) = fittingfn(x(:,labels == i));
    if Lc(i) > maxLc
        ncrest = i-1;
        break;
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

inliers = x(:,labels == -1);
plot(inliers(1,:), inliers(2,:),'.')
ab = polyfit(inliers(1,:), inliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(inliers(1,:)'),max(inliers(1,:)'));
F = a*X+b;
plot(X,F)


for i = 1:ncrest
    inliers = x(:,labels == i);
    plot(inliers(1,:), inliers(2,:),'.')
    
    X = linspace(0,Lc(i));
    F = fd(Lc(i), X);
    plot(X,F)
end

