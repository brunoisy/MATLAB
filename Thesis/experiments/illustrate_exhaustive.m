% this model generates data following our FD profile model
rng(3)
load('constants.mat')


tracenumber = 5;
 trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thisLc = 25;
Xin = dist;
Fin = force;
margin = 3;%1.5;
thresh = 0;%7;
inPeak = (Fin-thresh) < fd(thisLc+margin, Xin);%!!
inliers = (1:find(inPeak,1,'last'));
error = mean((force(inliers)-fd(thisLc, dist(inliers))).^2)

figure
colors = get(gca, 'colororder');
subplot(1,3,1)
hold on

title('L_c = 25');
xlabel('Distance (nm)');
ylabel('Force (pN)');
xlim([0, 60])
ylimits = [-100, 20];%[-140,20]
ylim(ylimits)
plot(dist,force,'.','markers',12)

Xfit = linspace(0,thisLc,1000);
Ffit = fd(thisLc, Xfit);
p1 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
p2 = plot(dist(inliers),force(inliers),'.','Color',colors(7,:),'markers',12);
legend([p1 p2], {'WLC curve','inliers'})

set(gca,'FontSize',24)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thisLc = 30;
Xin = dist;
Fin = force;
margin = 1.5;
thresh = 7;
inPeak = (Fin-thresh) < fd(thisLc+margin, Xin);%!!
inliers = (1:find(inPeak,1,'last'));
error = mean((force(inliers)-fd(thisLc, dist(inliers))).^2)

subplot(1,3,2)
hold on
title('L_c = 30');
xlabel('Distance (nm)');
% ylabel('Force (pN)');
xlim([0, 60])
ylim(ylimits)

plot(dist,force,'.','markers',12)

Xfit = linspace(0,thisLc,1000);
Ffit = fd(thisLc, Xfit);
p1 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
p2 = plot(dist(inliers),force(inliers),'.','Color',colors(7,:),'markers',12);
legend([p1 p2], {'WLC curve','inliers'})
set(gca,'FontSize',24)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
thisLc = 35;
Xin = dist;
Fin = force;
margin = 1.5;
thresh = 7;
inPeak = (Fin-thresh) < fd(thisLc+margin, Xin);%!!
inliers = (1:find(inPeak,1,'last'));
error = mean((force(inliers)-fd(thisLc, dist(inliers))).^2)

subplot(1,3,3)
hold on
title('L_c = 35');
xlabel('Distance (nm)');
% ylabel('Force (pN)');
xlim([0, 60])
ylim(ylimits)

plot(dist,force,'.','markers',12)


Xfit = linspace(0,thisLc,1000);
Ffit = fd(thisLc, Xfit);
p1 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
p2 = plot(dist(inliers),force(inliers),'.','Color',colors(7,:),'markers',12);
legend([p1 p2], {'WLC curve','inliers'})

set(gca,'FontSize',24)
