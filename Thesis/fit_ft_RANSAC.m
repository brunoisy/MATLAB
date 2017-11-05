filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

x = [dist; force];
x = x(:, 211:end); %simplification of problem

%%% 1 - We attempt to fit an FD curve to the first crest
s = 3;
thresh= 25*10^-12;





%%%% Plot
xlimits = [-10, 200];
ylimits = [-150, 25];
figure
subplot(1,2,1)
hold on
plot(10^9*x(1,:), 10^12*x(2,:),'.')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');


for i = 1:2%1:5 %to change
    [~, inliers] = ransac(x, @fittingfn, @distfn, @degenfn, s, thresh, 1, 100, 20);
    Lc = fittingfn(x(:,inliers));
    
    subplot(1,2,2)
    hold on
    xinliers = x(:, inliers);
    plot(10^9*xinliers(1,:), 10^12*xinliers(2,:),'.')
    X = linspace(0,Lc);
    F = fd(Lc, X);
    plot(10^9*X,10^12*F)
    
    
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    
    x = x(:,(inliers(end)+1:end)); % We remove all inliers from x and iterate
end

% note, distfn should be somewhat different for
% first crest