addpath('functions')
addpath('functions_ransac')

filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

x = [dist; force];
%x = x(:, 211:end); %simplification of problem !!

%%% 1 - We try to fit the 







% %%% 2 - We attempt to fit an FD curve to the different crests
% s = 3;
% thresh= 25*10^-12;
% 
% 
% allinliers = {};
% startinliers = 0;
% n = 1;
% for i=1:n%1:5% to change!!
%     [~,inliers] = ransac(x(:,startinliers+1:end), @fittingfn, @distfn, @degenfn, s, thresh, 1, 1000, 10);
%     Lc(i) = fittingfn(x(:,startinliers+inliers));
%     allinliers{1,i} = startinliers+inliers; 
%     startinliers = startinliers + inliers(end);
% end

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

thresh = 30*10^-12;
[~, inliers] = ransac(x, @linefittingfn, @linedistfn, @degenfn, 3, thresh, 1, 1000, 1000);
xinliers = x(:,inliers);


subplot(1,2,2)
hold on 
plot(10^9*xinliers(1,:), 10^12*xinliers(2,:),'.')
ab = polyfit(xinliers(1,:), xinliers(2,:), 1);
a = ab(1);
b = ab(2);
X = linspace(xinliers(1,1),xinliers(1,end));
F = a*X+b;
plot(10^9*X,10^12*F)

xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
% 
% subplot(1,2,2)
% hold on
% for i = 1:n
%     xinliers = x(:,allinliers{1,i});
%     plot(10^9*xinliers(1,:), 10^12*xinliers(2,:),'.')
%     X = linspace(0,Lc(i));
%     F = fd(Lc(i), X);
%     plot(10^9*X,10^12*F)
% end
% xlim(xlimits);
% ylim(ylimits);
% xlabel('Distance (nm)');
% ylabel('Force (pN)');
