function [] = lsq_fit_fd(filename, xlimits, ylimits, k, offset)
% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization

load('constants.mat')
load(filename)

x0 = 0;
%x0 = min(dist(force<0));% from physical reality, this is our best guess of the value of x0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force);
x1     = mins(1,1);% We will neglect the points <x1
mins   = mins(:,2:end);% We neglect the first minimum, which is always 'bad'


%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close
Lc = merge_Lc(find_Lc(mins, x0));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot
figure
subplot(1,k+1,1)

hold on
title('FD profile fit to minima')
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

plot(dist, force,'.')
plot(mins(1,1:end), mins(2,1:end),'*')

%%% Plot of the estimated FD curves
for i = 1:length(Lc)
    Xfit = linspace(0,Lc(i),1000);
    Ffit = fd(Lc(i), Xfit);
    plot((Xfit+x0), Ffit);
end
%firstLc = Lc; (memorized for plot)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xsel, Fsel, Xfirst, Xlast] = select_points(dist, force, x0, Lc, thresh, x1);
    
    
    %%% to do lsqfit, we need to convert to pN/nm and back (scaling issues)
    if(offset == true)
        x0Lc = lsqcurvefit(@(x0Lc,x) fd_multi(x0Lc,x,Xlast), [x0, Lc], Xsel,  Fsel);
        x0 = x0Lc(1);
        Lc = x0Lc(2:end);
    else
        Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xlast), Lc, Xsel,  Fsel);
    end
    [Lc, Xfirst, Xlast] = merge_Lc(Lc,Xfirst,Xlast);
    
    
    %%% Plot of the selected datapoints, and the estimated FD curves
    subplot(1,k+1,j+1)
    hold on
%     plot(0,0,'o')
%     plot(x0,0,'o')
%     legend('origin','offset')
    
    if(offset == true)
        title('FD profile fit to minimum lsq with free offset')
    else
        title('FD profile fit to minimum lsq')
    end
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    
    colors = ['.y', '.m', '.c', '.r', '.g', '.b', '.k'];
    for i=1:length(Lc)
        X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
        Y =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
        Xfit = linspace(0,Lc(i),1000);
        Ffit = fd(Lc(i), Xfit);
        if 
        plot(X, Y, '.');
        %plot((Xfit+x0),  Ffit);
        %         if(mod(i,2) == 0)
        %             plot(X, Y,'.b');
        %             plot((Xfit+x0),  Ffit,'b'); % least square fit
        %         else
        %             plot(X, Y,'.r');
        %             plot((Xfit+x0),  Ffit,'r'); % least square fit
        %         end
        
        %         %%% plot to initial curves for comparison
        %                 Xfit = linspace(0,firstLc(i),1000);
        %                 Ffit = fd(firstLc(i), Xfit);
        %                 plot((Xfit+x0(j)), Ffit,'k');
    end
    
end
end