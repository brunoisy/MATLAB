addpath('LSQ fit')
filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

xlimits = [-10, 200];
ylimits = [-150, 25];

load('constants.mat')
x0=0;


%%% first step is to find local minimas of the FD profile.
%%% We will assume those determine the position of a crest

mins = find_min(dist, force);
mins = mins(:,2:end);


figure
subplot(1,3,1)
hold on
xlim(xlimits);
ylim(ylimits);
plot(dist,force,'.')
plot(mins(1,1:end),mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD profile - series model')


%%%%%%%%%%%%%%%%%%%%% We fit FD curves assuming origin is the previous
%%%%%%%%%%%%%%%%%%%%% breaking point


Lc = zeros(1,length(mins)); % Lc represent lengths of intervals now !!
for i = 1:length(mins)
    if i==1
        xmin = mins(1,1);% because we want to find Lc wrt x0
    else
        xmin = mins(1,i)-mins(1,i-1);
    end
    fmin = mins(2,i);
    A = 4*fmin/C;
    p = [A, 2*xmin*(3-A), -xmin^2*(9-A), 4*xmin^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    
    Lc(i) = real(thisroots(1));
end


for i = 1:length(mins)
    X = linspace(0,Lc(i),1000);
    F = fd(Lc(i),X);
    if i==1
        plot(X+x0,F);
    else
        plot(X+mins(1,i-1),F)
    end
end


%%%%%%%%%%%%%%% We fit curve with origin at x0


subplot(1,3,2)
hold on
xlim(xlimits);
ylim(ylimits);
plot(dist,force,'.')
plot(mins(1,1:end),mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD profile - parallel model')

Lc = find_par_Lc(mins, x0);
for i = length(Lc):-1:1
    X = linspace(0,Lc(i),1000);
    F = fd(Lc(i),X);
    for j = (i+1):length(Lc)
        F = F + fd(Lc(j),X);
    end
    plot((X+x0),F)
end





Lc = find_Lc(mins,x0);

subplot(1,3,3)
hold on
xlim(xlimits);
ylim(ylimits);
plot(dist,force,'.')
plot(mins(1,1:end),mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD profile - series model with encrage points')

for i = 1:length(mins)
    X = linspace(0,Lc(i),1000);
    F = fd(Lc(i),X);
    plot((X+x0),F);
end
