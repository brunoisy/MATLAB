% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization
filename = 'data/MAT/data_2/curve_1.mat';
xlimits = [-10, 160];
ylimits = [-100, 20];


offset = false;
load('constants.mat')
load(filename)

x0 = 0;
%x0 = min(dist(force<0));% from physical reality, this is our best guess of the value of x0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force);
x1     = mins(1,1);% We will neglect the points <x1
mins   = mins(:,2:end);% We neglect the first minimum, which is always 'bad'


%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close
Lc = merge_Lc(find_Lc(mins, x0));


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
set(gca,'FontSize',14)

plot(dist, force,'.')
plot(mins(1,1:end), mins(2,1:end),'*')


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
    plot((Xfit+x0), Ffit);
end
%firstLc = Lc; (memorized for plot)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


%%% We select all the points that we will try to fit
[Xsel, Fsel, Xfirst, Xlast] = select_points(dist, force, x0, Lc, thresh, x1);


%%% to do lsqfit, we need to convert to pN/nm and back (scaling issues)
if(offset == true)
    x0Lc = lsqcurvefit(@(x0Lc,x) fd_multi(x0Lc,x,Xlast), [x0, Lc], Xsel,  Fsel);
    x0 = x0Lc(1);
    Lc = x0Lc(2:end);
else
    Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xlast), Lc, Xsel,  Fsel);
end
[Lc, Xfirst, Xlast] = merge_Lc(Lc,Xfirst,Xlast);


%%% Plot of the selected datapoints, and the estimated FD curves
subplot(1,4,3)
hold on
title('Selected Points')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',14)

colors = get(gca, 'colororder');
for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
    Y =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
   
    plot(X,Y,'.','Color',colors(i+2,:))
end


subplot(1,4,4)
hold on
title('FD profile fit to minimum Least-Squares')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
set(gca,'FontSize',14)


for i=1:length(Lc)
    X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
    Y =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    
    plot(X,Y,'.','Color',colors(i+2,:))
    plot((Xfit+x0),  Ffit,'Color',colors(i+2,:))
end
