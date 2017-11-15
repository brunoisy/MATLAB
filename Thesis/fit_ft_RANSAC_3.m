addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_16.mat';
%filename = 'data/MAT/data_1/good/curve_2.mat';

load(filename)
x = [dist; force];
%x = preprocess(x);

index = 1:length(x);
free = true(1,length(x));

allinliers = cell(1,10);
Lc = zeros(1,10);

maxLc = 220;


%%% 1 - We fit a first line to the profile, to get rid of approaching phase
thresh = 9;
[~, inliers]  = ransac(x(:,free), @linefittingfn, @linedistfn, @degenfn, 2, thresh, 1, 10, 50, true);
allinliers{1} = inliers;
start_ind     = inliers(end);
free(1:start_ind) = false(1,start_ind);

thresh = 2;
[~, inliers]  = ransac(x(:,free), @linefittingfn, @linedistfn, @degenfn, 2, thresh, 1, 10, 200, true);
inliers       = start_ind+inliers;
allinliers{2} = inliers;
start_ind     = inliers(end);
free(1:start_ind) = false(1,start_ind);

% 
% dist_thresh = 9;
% outliers = index(x(1,:) < start + dist_thresh);
% start_ind = outliers(end);
% start = x(1,start_ind);
% free(1:start_ind) = false(1,start_ind);



%%% 2 - We attempt to fit an FD curve to the different crests
thresh = 15;
for i = 1:10
    if ~any(free)
        ncrest = i-1;
        break
    end
    [~,inliers]     = ransac_2(x(:,free), @fittingfn, @distfn_2, @degenfn, 1, thresh, 1, 10, 30);
    inliers         = start_ind+inliers;
    allinliers{2+i} = inliers;
    start_ind       = inliers(end);

    free(1:start_ind) = false(1,start_ind);
    
    Lc(i) = fittingfn(x(:,inliers));
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
title('approximated FD curves using RANSAC');

xinliers = x(:,allinliers{1});
plot(xinliers(1,:), xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(xinliers(1,:)'),max(xinliers(1,:)'));
F = a*X+b;
plot(X,F)


xinliers = x(:,allinliers{2});
plot(xinliers(1,:), xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(xinliers(1,:)'),max(xinliers(1,:)'));
F = a*X+b;
plot(X,F)


for i = 1:ncrest
    xinliers = x(:,allinliers{2+i});
    plot(xinliers(1,:), xinliers(2,:),'.')
    
    X = linspace(0,Lc(i));
    F = fd(Lc(i), X);
    plot(X,F)
end

