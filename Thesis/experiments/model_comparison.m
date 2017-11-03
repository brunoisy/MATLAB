addpath('functions')
filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

xlimits = [-10, 200];
ylimits = [-150, 25];

kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;

x0 = min(dist(force<0));% from physical reality, this is our best guess of the value of x0


%%% first step is to find local minimas of the FD profile.
%%% We will assume those determine the position of a crest

mins = find_min(dist, force);
mins = mins(:,2:end);


figure
subplot(1,3,1)
hold on
xlim(xlimits);
ylim(ylimits);
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD curves sequence')


%%%%%%%%%%%%%%%%%%%%% We fit FD curves assuming origin is the previous
%%%%%%%%%%%%%%%%%%%%% breaking point

Lc = zeros(1,length(mins)); % Lc represent lengths of intervals now !!
for i = 1:length(mins)
    if i==1
        Xi = mins(1,i);
    else
        Xi = mins(1,i)-mins(1,i-1);
    end
    Fi = mins(2,i);
    
    A = 4*Fi/C;
    p = [A, 2*Xi*(3-A), -Xi^2*(9-A), 4*Xi^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    Lc(i) = real(thisroots(1));
end

for i = 1:length(mins)
    X = linspace(0,Lc(i),1000);
    F = fd(Lc(i),X);
    if i==1
        plot(10^9*(X+x0),10^12*F);
    else
        plot(10^9*(X+mins(1,i-1)),10^12*F)
    end
end


%%%%%%%%%%%%%%% We fit curve with origin at x0
Lc = find_Lc(mins,x0);

subplot(1,3,2)
hold on
xlim(xlimits);
ylim(ylimits);
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD curves parallel simpified')

for i = 1:length(mins)
    X = linspace(0,Lc(i)*95/100,1000);
    F = fd(Lc(i),X);
    plot(10^9*(X+x0),10^12*F);
end







subplot(1,3,3)
hold on
xlim(xlimits);
ylim(ylimits);
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD curves parallel')

Lc = find_par_Lc(mins, x0);
for i = length(Lc):-1:1
    X = linspace(0,Lc(i),1000);
    F = fd(Lc(i),X);
    for j = (i+1):length(Lc)
        F = F + fd(Lc(j),X);
    end
    plot(10^9*(X+x0),10^12*F)
end