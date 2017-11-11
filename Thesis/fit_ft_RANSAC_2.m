addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_5.mat';%5? 7??
%filename = 'data/MAT/data_1/good/curve_2.mat';

load(filename)
% 
% force = force(dist>0);
% dist = dist(dist>0);
% dist = dist - dist(1);
x = [dist; force];

maxLc = 160;
s = 3;
allinliers = {};
startinliers = 0;



%%% 1 - We fit a first line to the profile, to get rid of approaching phase
thresh = 8;
[~, inliers] = ransac(x, @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 10, 200, true);
allinliers{1,1} = inliers;
startinliers = startinliers + inliers(end);


%%% 1 - We fit a horizontal line to the last points, to get rid of end
%%% noise
thresh = 20;
[~, inliers] = ransac(x(:,startinliers:end), @linefittingfn, @linedistfn_2, @degenfn, 5, thresh, 1, 10, 200, false, true);
allinliers{1,2} = startinliers + inliers-1;
stopinliers = startinliers + inliers(1);


%%% 3 - We attempt to fit an FD curve to the different crests
ncrest = 0;
Lc = zeros(1,10);
for i = 1:10
    thresh = 20;
    [~,inliers] = ransac(x(:,startinliers+1:stopinliers), @fittingfn, @distfn_2, @degenfn, 1, thresh, 1, 10, 200);
    if isempty(inliers)
        break
    else
        Lc(i) = fittingfn(x(:,startinliers+inliers));
        if Lc(i) > maxLc
            break
        end
        allinliers{1,2+i} = startinliers + inliers;
        startinliers = startinliers + inliers(end);
        
        ncrest = ncrest+1;
        if startinliers == stopinliers % (this should not happen)
            break
        end
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
plot(x(1,:), x(2,:),'.')



subplot(1,2,2)
hold on
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');


xinliers = x(:,allinliers{1,1});
plot(xinliers(1,:), xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(xinliers(1,:)'),max(xinliers(1,:)'));
F = a*X+b;
plot(X,F)



xinliers = x(:,allinliers{1,2});
plot(xinliers(1,:), xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(min(xinliers(1,:)'),max(xinliers(1,:)'));
F = a*X+b;
plot(X,F)



for i = 1:ncrest
    xinliers = x(:,allinliers{1,2+i});
    plot(xinliers(1,:), xinliers(2,:),'.')
    
    X = linspace(0,Lc(i));
    F = fd(Lc(i), X);
    plot(X,F)
end

