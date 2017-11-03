filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

x = [dist; force];
%%% 1 - We attempt to fit an FD curve to the first crest
s = 4;
thresh = 10*10^-12;
[Lc, inliers] = ransac(x, @fittingfn, @distfn, @degenfn, s, thresh);



%%%% Plot
xlimits = [-10, 200];
ylimits = [-150, 25];
figure
subplot(1,2,1)
hold on
plot(10^9*dist, 10^12*force,'.')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');


subplot(1,2,2)
hold on
plot(10^9*inliers(1,:), 10^12*inliers(2,:),'.')
X = linspace(0,Lc);
F = fd(Lc, X);
plot(10^9*X,10^12*F)


xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');


% note, distfn should be somewhat different for
% first crest