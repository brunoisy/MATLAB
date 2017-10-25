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
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %%%%%% First step : find local minimas of the FD profile.
% %%%%%% These will help us estimate the position of the crest
% %%%%%% The first estimations are the FD curves going through the minima
% mins   = find_min(dist, force);
% x1     = mins(1,1);
% mins   = mins(:,2:end); %We neglect the first minimum, which is always 'bad'
% nmin   = length(mins);
% 
% %%% We find the FD curves going through the minimas, parametrized by Lc
% Lc = zeros(1,nmin);
% for i = 1:nmin
%     xmin = mins(1,i)-x0;%because we want to find Lc wrt x0
%     fmin = mins(2,i);
%     
%     A = 4*fmin/C;
%     p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
%     thisroots = roots(p);
%     thisroots = thisroots(thisroots>0);
%     
%     Lc(i) = real(thisroots(1));
% end



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
hi = 1;
movmeanforce = zeros(1, length(force)-2*hi);
for i = 1:length(movmeanforce)
    movmeanforce(i) = mean(force(i:(i+2*hi)));
end
length(dist(hi:end-hi))
plot(10^9*dist(hi:end-hi-1),10^12*movmeanforce)
%plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')


% %%% Plot of the estimated FD curves
% for i = 1:nmin
%     Xfit = linspace(0,Lc(i),1000);
%     Ffit = fd(Lc(i), Xfit);
%     plot(10^9*(Xfit+x0),10^12*Ffit);
% end

