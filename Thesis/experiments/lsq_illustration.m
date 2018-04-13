% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization
filename = 'data/MAT_clean/data_4/curve_12.mat';%'data/MAT_clean/data_2/curve_16.mat';
% xlimits = [0, 140];
% ylimits = [-80, 0];
xlimits = [-10, 150];
ylimits = [-300, 50];

load('constants.mat')
load(filename)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force, 20);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close
Lc = merge_Lc(find_Lc(mins, 0));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot
figure
subplot(1,4,1)

hold on
title('Minima Selection','FontSize',16)
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(dist, force,'.')
plot(mins(1,1:end), mins(2,1:end),'*')
set(gca,'FontSize',22)

subplot(1,4,2)
hold on
title('FD profile fit to minima')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',14)

plot(dist, force,'.')
plot(mins(1,1:end), mins(2,1:end),'*')

%%% Plot of the estimated FD curves
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit, Ffit);
end
set(gca,'FontSize',22)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


%%% We select all the points that we will try to fit
[Xsel, Fsel, Xfirst, Xunfold] = select_points(dist, force, 0, Lc, thresh);



Lc = lsqcurvefit(@(Lc,x) fd_multi([0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
[Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);


%%% Plot of the selected datapoints, and the estimated FD curves
% subplot(1,4,3)
hold on
title('Selected Points')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',22)

colors = get(gca, 'colororder');
for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y = Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
   
    plot(X,Y,'.','Color',colors(i+2,:))
end


subplot(1,4,4)
hold on
title('FD profile fit to min LSQ')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',22)


for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    
    plot(X,Y,'.','Color',colors(i+2,:))
    plot(Xfit,  Ffit,'Color',colors(i+2,:))
end
