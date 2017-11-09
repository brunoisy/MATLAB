addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

x = [dist; force]; 
%x = x(:, 211:end); %simplification of problem !!


s = 3;
allinliers = {};
startinliers = 0;

%%% 1 - We fit a first line to the profile
thresh = 9;
[~, inliers] = ransac(x, @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 1000, 100, true);
allinliers{1,1} = inliers;
startinliers = startinliers + inliers(end);

%%% 2 - We fit a second line to the profile
thresh = 2;
[~, inliers] = ransac(x(:,startinliers+1:end), @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 1000, 100, true);
allinliers{1,2} = startinliers+inliers;
startinliers = startinliers + inliers(end);

%%% 3 - We attempt to fit an FD curve to the different crests
for i=3:7% to change!!
    thresh = 20;
    [~,inliers] = ransac(x(:,startinliers+1:end), @fittingfn, @distfn_2, @degenfn, s, thresh, 1, 1000, 50);
    allinliers{1,i} = startinliers + inliers;
    startinliers = startinliers + inliers(end);
end







%%%% Plot
xlimits = [-10, 200];
ylimits = [-150, 400];

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

for i = 1:2
    xinliers = x(:,allinliers{1,i});
    plot(xinliers(1,:), xinliers(2,:),'.')
    ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
    a = ab(1);
    b = ab(2);
    X = linspace(min(xinliers),max(xinliers));
    F = a*X+b;
    plot(X,F)
end

for i = 3:7
    xinliers = x(:,allinliers{1,i});
    plot(xinliers(1,:), xinliers(2,:),'.')
    
    Lc = fittingfn(xinliers);
    X = linspace(0,Lc);
    F = fd(Lc, X);
    plot(X,F)

end

