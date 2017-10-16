global C
kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;

directory = 'data/MAT/data_2/';
%directory = 'data/MAT/data_1/good';
%directory = 'data/MAT/data_1/bad';



for filenumber = 1:5
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    
    %%% first step is to find local minimas of the FD profile.
    %%% We will assume those determine the position of a crest
    
    nmin = 0;% # of minimas found
    maxmin = 100;
    mins = zeros(2, maxmin);
    hi = 20;% size of half comparison interval...
    fthresh = -25*10^-12; % max value of force for a candidate to be considered a minima
    for i=1+hi:length(force)-hi
        if ( (force(i) < min([force(i-hi:i-1),force(i+1:i+hi)])) && (force(i) < fthresh)) 
            nmin = nmin+1;
            mins(:,nmin) = [dist(i); force(i)];
        end
    end
    mins = mins(:,2:nmin);% starting at 2 'cause first min is always bad
    nmin = nmin-1;
    
    
%     %%%%%%
%    
%     nmax = 0;% # of maximas found
%     maxmax = 100;
%     maxs = zeros(2, maxmax);
%     hi = 20;% size of half comparison interval...
%     %fthresh = -25*10^-12; % max value of force for a candidate to be considered a minima
%     for i=1+hi:length(force)-hi
%         if ( (force(i) > max([force(i-hi:i-1),force(i+1:i+hi)]))) 
%             nmax = nmax+1;
%             maxs(:,nmax) = [dist(i); force(i)];
%         end
%     end
%     maxs = maxs(:,2:nmax);% starting at 2 'cause first max is always bad
%     nmax = nmax-1;
%     
%     %%%%%%
    
    
    
    
    figure(1)
    hold on
    plot(10^9*dist,10^12*force,'.')
%     plot(10^9*mins(1,1:end),10^12*mins(2,1:end),'*')
%     plot(10^9*maxs(1,1:end),10^12*maxs(2,1:end),'o')
   % legend('data','minima','maxima')
    
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
    
    for i=1:nmin
        X = linspace(0,Lc(i)*95/100,1000);
        F = fd_curve(Lc(i),X);
%         plot(10^9*X,10^12*F);
%         title('FD curves fit to minimas')
%         xlabel('Distance (nm)');
%         ylabel('Force (pN)');
    end
    
    
  
end





% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% %%% second step is to use these curves as starting point and use minimum
% %%% least square fit on the points between 2 crests
% 
% Lfit = Lc; % L's according to least square fit, prior is = Lc
% 
% 
% for i = 2:nmin
%     % We select the points that are between this minima and the previous
%     % one, and fit a FD curve with min least squares
%     if (i==1)
%         Xs = dist(dist(dist <= mins(1,i))>0); %carefull, locmin looses some info!!
%         Fs = force(dist(dist <= mins(1,i))>0);   
%     else
%         Xs = dist(dist(dist <= mins(1,i))>Lfit(1,i-1)); %carefull, locmin looses some info!!
%         Fs = force(dist(dist <= mins(1,i))>Lfit(1,i-1));    
%     end
%     
%     
%     
%     Fx = @(Lc,x) -C*(1./(4*(1-x/Lc).^2)-1/4+x/Lc);
%     %options = optimoptions('lsqcurvefit','FunctionTolerance',10^-10);
%     %options = optimset('MaxFunctionEvaluations',500);
%     Lfit(i) = lsqcurvefit(Fx, Lfit(i), Xs, Fs);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     %%% second step is to use these curves as starting point and use minimum
%     
%     plot(10^9*Xs, 10^12*Fs,'.'); %initial datapoints
%     X = linspace(0,Lfit(i)*95/100,1000);
%     plot(10^9*X, 10^12*fd_curve(Lfit(i),X)); %least square fit
%     title('FD curves fit to least squares')
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
% end