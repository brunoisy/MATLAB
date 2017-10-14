global C
kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;


for filenumber = 1
    %filename = strcat('data_1/good/curve_',int2str(filenumber),'.txt');
    %filename = strcat('data_2/curve_',int2str(filenumber),'.txt');
    filename = strcat('data_model/curve_',int2str(filenumber),'.txt');
    
    fileID = fopen(filename);
    Text = textscan(fileID, '%f %f');
    fclose(fileID);
    
    dist = Text{1}/10^9;%10^15; % distance in m
    force = Text{2}/10^12;%10^18; % force in N 
    
    
    %%% first step is to find local minimas of the FD profile.
    %%% We will assume those determine the position of a crest
    
    maxmin = 13;%(max # of maxmin local minimas)
    locmin = zeros(2,maxmin);
    a = 1;
    hi = 20; %size of half interval...
    for i=1+hi:length(force)-hi
        locmin(:,a) = [dist(i); force(i)];
        a = a+1;
        if a>maxmin
            break
        end
        for j=[-hi:-1,1:hi]
            if(force(i+j)<force(i))
                a = a-1;
                break
            end
        end
    end
    
%     % we compensate for offset
%     dist = dist-locmin(1,1);%better to subtract mean
%     locmin(1,:) = locmin(1,:)-locmin(1,1);
    
    figure(1)
    hold on
    plot(10^9*dist,10^12*force,'.')
    plot(10^9*locmin(1,2:end),10^12*locmin(2,2:end),'*')
    legend('data','minima')
    
    Lc = zeros(1,maxmin);
    for i = 2:maxmin % starting at 2 'cause first min is always bad
        Xi = locmin(1,i);
        Fi = locmin(2,i);
        
        A = 4*Fi/C;
        p = [A, 2*Xi*(3-A), -Xi^2*(9-A), 4*Xi^3];
        thisroots = roots(p);
        thisroots = thisroots(thisroots>0);
        Lc(i) = real(thisroots(1));
    end
    
    for i=2:maxmin
        X = linspace(0,Lc(i)*95/100,1000);
        F = fd_curve(Lc(i),X);
        plot(10^9*X,10^12*F);
        title('FD curves fit to minimas')
        xlabel('Distance (nm)');
        ylabel('Force (pN)');
    end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% %%% second step is to use these curves as starting point and use minimum
% %%% least square fit on the points between 2 crests
%
% Lfit = Lc; % L's according to least square fit, prior is = Lc
%
% figure(2)
% hold on
% plot(10^9*dist,10^12*force,'.')
% for i=3:maxmin % for each valid minima, first one is messy
%     % We select the points that are between this minima and the previous
%     % one, and fit a FD curve with min least squares
%     Xs = dist(dist(dist <= locmin(1,i))>Lfit(1,i-1)); %carefull, locmin looses some info!!
%     Fs = force(dist(dist <= locmin(1,i))>Lfit(1,i-1));
%
%
%     Fx = @(Lc,x) -C*(1./(4*(1-x/Lc).^2)-1/4+x/Lc);
%     %options = optimoptions('lsqcurvefit','FunctionTolerance',10^-10);
%     %options = optimset('MaxFunctionEvaluations',500);
%     Lfit(i) = lsqcurvefit(Fx, Lfit(i), Xs, Fs);
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% %%% second step is to use these curves as starting point and use minimum
%
%     plot(10^9*Xs, 10^12*Fs,'.'); %initial datapoints
%     X = linspace(0,Lfit(i)*95/100,1000);
%     plot(10^9*X, 10^12*fd_curve(Lfit(i),X)); %least square fit
%     title('FD curves fit to least squares')
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
% end