addpath('functions')
filename = 'data/MAT/data_1/good/curve_4.mat';
%filename = 'data/MAT/data_model/curve_2.mat';
load(filename)

kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
C  = kb*T/lp;

xlimits = [-10, 200];
ylimits = [-150, 25];%[-100, 50];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% First step : find local minimas of the FD profile.
%%%%%% These will help us estimate the position of the crest
%%%%%% The first estimations are the FD curves going through the minima
maxmin = 8;
mins   = find_min(dist, force, maxmin);
mins   = mins(:,2:end);%first min is often bad
nmin   = length(mins);

%%% We find the FD curves going through the minimas, parametrized by Lc
Lc = zeros(1,nmin);
for i = 1:nmin
    xmin = mins(1,i);
    fmin = mins(2,i);
    
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end

figure
subplot(1,2,1)

%%% Plot of the data
hold on
title('FD curves fit to minimas')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')

legend('data','minima')

%%% Plot of the estimated FD curves
for i = 1:nmin
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot(10^9*Xfit,10^12*Ffit);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% We can now select points that likely belong to the found Fd
%%%%%% curves, apply least-square-fit to get a better estimate of Lc,
%%%%%% and iterate

%%% We select all the points that we will try to fit
thresh = 10*10^-12;
xmin = 11*10^-9;
[Xsel, Fsel, Xcut] = select_points(dist, force, x0, Lc, thresh, min(xmin,Lc(1)));

%%% we need to convert to pN/nm and back
Lc = lsqcurvefit(@(Lc,x)10^12*multi_fd([x0, Lc],x,10^9*Xcut), 10^9*Lc, 10^9*Xsel, 10^12*Fsel)/10^9;



%%% Plot of the selected datapoints, and the estimated FD curves
subplot(1,2,2)
hold on
title('FD curves fit to minimum lsq with offset')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(10^9*Xsel, 10^12*Fsel,'.'); % selected datapoints


for i=1:length(Lc)
   Xfit = linspace(0,Lc(i),1000);
   Ffit = fd(Lc(i), Xfit);
   plot(10^9*(Xfit+x0), 10^12*Ffit); % least square fit
end