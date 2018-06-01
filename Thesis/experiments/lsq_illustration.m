% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization
filename = 'data/MAT_clean/data_4/curve_6.mat';%6 instead? 11
% xlimits = [0, 140];
% ylimits = [-80, 0];
xlimits = [0, 110];
ylimits = [-100, 20];

load('constants.mat')
load(filename)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force, 20);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close
Lc = merge_Lc(find_Lc(mins, 0),zeros(1,length(mins)), zeros(1,length(mins)));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot
figure('units','normalized','outerposition',[0 0 1 1]);
colors = get(gca, 'colororder');
colors = colors([1,2,4,5,6,7],:);%don't like yellow...

subplot(2,2,1)

hold on
title('Minima Selection','FontSize',16)
xlim(xlimits);
ylim(ylimits);
% xlabel('Distance (nm)');

ylabel('Force (pN)');
plot(dist, force,'.','markers',12)
plot(mins(1,1:end), mins(2,1:end),'.','markers',30);
set(gca,'FontSize',24)

%%
% figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,2)

hold on
title('Minima WLC profile')
xlim(xlimits);
ylim(ylimits);
% xlabel('Distance (nm)');
% ylabel('Force (pN)');
set(gca,'FontSize',14)

plot(dist, force,'.','markers',12)
plot(mins(1,1:end), mins(2,1:end),'.','markers',30);

%%% Plot of the estimated FD curves
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(Xfit, Ffit,'Color',colors(mod(i,6)+1,:),'LineWidth',2);
end
set(gca,'FontSize',24)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


%%% We select all the points that we will try to fit
[Xfirst, Xunfold] = select_points(dist, force, 0, Lc, thresh, thresh);
Xsel = [];
Fsel = [];
for i = 1:length(Lc)
    Xsel = [Xsel, dist(Xfirst(i)<=dist & dist<=Xunfold(i))];
    Fsel = [Fsel, force(Xfirst(i)<=dist & dist<=Xunfold(i))];
end


Lc = lsqcurvefit(@(Lc,x) fd_multi_old([0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
[Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);


%%% Plot of the selected datapoints, and the estimated FD curves
% figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,3)

hold on
title('Identified Peaks')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',24)

plot(dist,force,'.','markers',12);
for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y = Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    
    plot(X,Y,'.','Color',colors(mod(i,6)+1,:),'markers',12)
end

% figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,4)

hold on
title('Least-Squares WLC profile')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
% ylabel('Force (pN)');
set(gca,'FontSize',24)

plot(dist,force,'.','markers',12);

for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Y =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    
    plot(X,Y,'.','Color',colors(mod(i,6)+1,:),'markers',12)
    plot(Xfit,  Ffit,'Color',colors(mod(i,6)+1,:),'LineWidth',2)
end
