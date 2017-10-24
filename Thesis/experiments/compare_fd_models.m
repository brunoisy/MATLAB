addpath('functions')
filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;


%%% first step is to find local minimas of the FD profile.
%%% We will assume those determine the position of a crest

maxmin = 6;
mins = find_min(dist, force, maxmin);
nmin = length(mins);


figure
subplot(1,2,1)
hold on
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD curves with origin at 0')
ylim([-100, 50]);
xlim([0, 200]);

%%%%%%%%%%%%%%%%%%%%% We fit FD curves assuming origin is always at 0

Lc = zeros(1,nmin);
for i = 1:nmin
    Xi = mins(1,i);
    Fi = mins(2,i);
    
    A = 4*Fi/C;
    p = [A, 2*Xi*(3-A), -Xi^2*(9-A), 4*Xi^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    Lc(i) = real(thisroots(1));
end

for i = 1:nmin
    X = linspace(0,Lc(i)*95/100,1000);
    F = fd(Lc(i),X);
    plot(10^9*X,10^12*F);
end

subplot(1,2,2)
hold on
plot(10^9*dist,10^12*force,'.')
plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
legend('data','minima')
xlabel('Distance (nm)');
ylabel('Force (pN)');
title('FD curves with origin at Lc(i-1)')
ylim([-100, 50]);
xlim([0, 200]);

%%%%%%%%%%%%%%%%%%%%% We fit FD curves assuming origin is the previous
%%%%%%%%%%%%%%%%%%%%% singularity

Lc = zeros(1,nmin); % Lc represent lengths of intervals now !!
for i = 1:nmin
    Xi = mins(1,i)-sum(Lc(1:i-1));
    Fi = mins(2,i);
    
    A = 4*Fi/C;
    p = [A, 2*Xi*(3-A), -Xi^2*(9-A), 4*Xi^3];
    thisroots = roots(p);
    thisroots = thisroots(thisroots>0);
    Lc(i) = real(thisroots(1));
end

for i = 1:nmin
    X = linspace(0,Lc(i)*95/100,1000);
    F = fd(Lc(i),X);
    plot(10^9*(X+sum(Lc(1:i-1))),10^12*F);
end