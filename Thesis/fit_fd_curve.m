addpath('functions')
filename = 'data/MAT/data_2/curve_2.mat';
%filename = 'data/MAT/data_model/curve_3.mat';
load(filename)

kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
C  = kb*T/lp;

xlimits = [-10, 200];
ylimits = [-150, 25];

x0 = min(dist(force<0));% from physical reality, this is our best guess of the value of x0
k = 2;% number of iterations of lsq/selection

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% First step : find local minimas of the FD profile.
%%%%%% These will help us estimate the position of the crest
%%%%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force);
x1     = mins(1,1);
mins   = mins(:,2:end); %We neglect the first minimum, which is always 'bad'
nmin   = length(mins);

%%% We find the FD curves going through the minimas, parametrized by Lc
Lc = zeros(1,nmin);
for i = 1:nmin
    xmin = mins(1,i)-x0;% because we want to find Lc wrt x0
    fmin = mins(2,i);
    
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end

Lc = mergeLc(Lc);


figure
subplot(1,k+1,1)

%%% Plot of the data
hold on
title('FD curves fit to minimas')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(0,0,'o')
plot(x0*10^9,0,'o')
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')

legend('origin','offset','data','minima')

%%% Plot of the estimated FD curves
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(10^9*(Xfit+x0),10^12*Ffit);
end
%firstLc = Lc; (memorized for plot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% We can now select points that likely belong to the found Fd
%%%%%% curves, apply least-square-fit to get a better estimate of Lc,
%%%%%% and iterate

thresh = 10*10^-12;%


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xsel, Fsel, Xfirst, Xlast] = select_points(dist, force, x0, Lc, thresh, x1);
    
    
    %%% to do lsqfit, we need to convert to pN/nm and back (scaling issues)
    Lc = lsqcurvefit(@(Lc,x)10^12*multi_fd([10^9*x0,Lc],x,10^9*Xlast), 10^9*Lc, 10^9*Xsel, 10^12*Fsel)/10^9;
    [Lc, Xfirst, Xlast] = mergeLc(Lc,Xfirst,Xlast);
    
    
    %%% Plot of the selected datapoints, and the estimated FD curves
    subplot(1,k+1,j+1)
    hold on
    title('FD curves fit to minimum lsq with offset')
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    
    plot(0,0,'o')
    plot(x0*10^9,0,'o')
    legend('origin','offset')
    
    for i=1:length(Lc)
        X = 10^9*Xsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
        Y = 10^12*Fsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        if(mod(i,2) == 0)
            plot(X, Y,'.b');
            plot(10^9*(Xfit+x0), 10^12*Ffit,'b'); % least square fit
        else
            plot(X, Y,'.r');
            plot(10^9*(Xfit+x0), 10^12*Ffit,'r'); % least square fit
        end
        %         %%% plot to initial curves for comparison
        %                 Xfit = linspace(0,firstLc(i),1000);
        %                 Ffit = fd(firstLc(i), Xfit);
        %                 plot(10^9*(Xfit+x0(j)),10^12*Ffit,'k');
    end
    
end