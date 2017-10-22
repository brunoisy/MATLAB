filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

kb = 1.38064852e-23;
T  = 294;
lp = 0.36*10^-9;
C  = kb*T/lp;

xlimits = [-10, 200];
ylimits = [-100, 50];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% First step : find local minimas of the FD profile.
%%%%%% These will help us estimate the position of the crest
%%%%%% The first estimations are the FD curves going through the minima
maxmin = 7;
mins = find_min(dist, force, maxmin);
nmin = length(mins);

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

x0 = 0;% initial guess for offset

%%% We select all the points that we will try to fit
thresh = 10*10^-12;
[Xsel, Fsel] = select_points(dist, force, x0, Lc, thresh);

% %%% we need to convert to pN/nm and back
% x0Lc = lsqcurvefit(@(x0Lc,x)10^12*multi_fd(x0Lc,x), [x0, Lc], 10^9*Xsel, 10^12*Fsel)/10^9;
% x0 = x0Lc(1);
% Lc = x0Lc(2:end);

%%% Plot of the selected datapoints, and the estimated FD curves
subplot(1,2,2)
hold on
title('FD curves fit to minimum lsq')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(10^9*Xsel, 10^12*Fsel,'.'); % selected datapoints

Xfit = linspace(x0,Lfit(end),5000);
Ffit = multi_fd([x0, Lfit],Xfit);

plot(10^9*Xfit, 10^12*Ffit,'.'); % least square fit

