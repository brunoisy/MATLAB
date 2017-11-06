filename = strcat('data/MAT/data_2/curve_1.mat');
load(filename)

load('constants.mat')



%%% first step is to find local minimas of the FD profile.
%%% We will assume those determine the position of a crest

maxmin = 100;
mins = find_min(dist, force, maxmin);
nmin = length(mins);


maxmax = 100;
maxs = find_max(dist, force, maxmax);
nmax = length(maxs);






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


for i=1:nmin
    Xcrest  =  dist((dist>maxs(1,i)) & (dist < mins(1,i)));
    Fcrest  = force((dist>maxs(1,i)) & (dist < mins(1,i)));
    X = linspace(0,Lc(i)*90/100,1000);
    F = fd(Lc(i),X);
    noise = (fd(Lc(i),Xcrest)-Fcrest);
    
    figure
    subplot(1,2,1)
    hold on
    plot(Xcrest,Fcrest,'.');
    plot(X,F);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    legend('points considered', 'curve')
    
    subplot(1,2,2)
    hold on
    hist(noise)
end


