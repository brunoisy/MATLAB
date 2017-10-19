filename = 'data/MAT/data_2/curve_1.mat';
load(filename)

global C
kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;


%%% first step is to find local minimas of the FD profile.
%%% We will assume those determine the position of a crest

nmin = 0;% # of minimas found
maxmin = 6;
mins = zeros(2, maxmin);
hi = 20;% size of half comparison interval...
fthresh = -25*10^-12;% max value of force for a candidate to be considered a minima
for i=1+hi:length(force)-hi
    if ( (force(i) < min([force(i-hi:i-1),force(i+1:i+hi)])) && (force(i) < fthresh))
        nmin = nmin+1;
        mins(:,nmin) = [dist(i); force(i)];
        if(nmin >= maxmin)
            break
        end
    end
end
mins = mins(:,2:nmin);% starting at 2 'cause first min is always bad
nmin = nmin-1;


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
    F = fd_curve(Lc(i),X);
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
    F = fd_curve(Lc(i),X);
    plot(10^9*(X+sum(Lc(1:i-1))),10^12*F);
end