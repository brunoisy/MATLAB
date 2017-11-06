directory = 'data/MAT/data_2/';
%directory = 'data/MAT/data_1/good/';
%directory = 'data/MAT/data_1/bad/';

kb = 1.38064852e-23;
T  = 294;
lp = 0.36;
C  = kb*T/lp;

xlimits = [-10, 200];
ylimits = [-150, 25];

Lcs = zeros(10,18);%instead of zeros to avoid bad clustering
for filenumber = 1:18%19 is problematic
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    
    x0 = min(dist(force<0));% from physical reality, this is our best guess of the value of x0
    k = 2;% number of iterations of lsq/selection
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%% First step : find local minimas of the FD profile.
    %%%%%% These will help us estimate the position of the crest
    %%%%%% The first estimations are the FD curves going through the minima
    mins   = find_min(dist, force);
    x1     = mins(1,1);
    mins   = mins(:,2:end); %We neglect the first minimum, which is always 'bad'
    nmin   = length(mins);
    
    %%% We find the FD curves going through the minimas, parametrized by Lc
    Lc = merge_Lc(find_Lc(mins, x0));

    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%% We can now select points that likely belong to the found Fd
    %%%%%% curves, apply least-square-fit to get a better estimate of Lc,
    %%%%%% and iterate
    
    thresh = 10;%pN
    
    
    for j = 1:k
        %%% We select all the points that we will try to fit
        [Xsel, Fsel, Xfirst, Xlast] = select_points(dist, force, x0, Lc, thresh, x1);
        
        
        %%% to do lsqfit, we need to convert to pN/nm and back (scaling issues)
        Lc = lsqcurvefit(@(Lc,x)fd_multi([x0,Lc],x,Xlast), Lc, Xsel, Fsel);
        [Lc, Xfirst, Xlast] = merge_Lc(Lc,Xfirst,Xlast);
    end
    
%     %%% Plot of the selected datapoints, and the estimated FD curves
%     figure(1)
%     hold on
%     title('FD curves fit to minimum lsq with offset')
%     xlim(xlimits);
%     ylim(ylimits);
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
%     
%     
%     for i=1:length(Xlast)
%         X = 10^9*Xsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
%         Y = 10^12*Fsel(Xfirst(i)<=Xsel & Xsel<=Xlast(i));
%         Xfit = linspace(0,Lc(i),1000);
%         Ffit = fd(Lc(i), Xfit);
%         if(mod(i,2) == 0)
%             %plot(X, Y,'.b');
%             plot(10^9*(Xfit+x0), 10^12*Ffit,'b'); % least square fit
%         else
%             %plot(X, Y,'.r');
%             plot(10^9*(Xfit+x0), 10^12*Ffit,'r'); % least square fit
%         end
%         %         %%% plot to initial curves for comparison
%         %                 Xfit = linspace(0,firstLc(i),1000);
%         %                 Ffit = fd(firstLc(i), Xfit);
%         %                 plot(10^9*(Xfit+x0(j)),10^12*Ffit,'k');
%     end
    
    
    Lcs(1:length(Lc),filenumber) = Lc;
end
% Lcs
% idx = kmeans(10^9*Lcs', 5)
%
% for i=1:length(idx)
%     filename = strcat(directory,'curve_',int2str(i),'.mat');
%     load(filename)
%     %%% Plot of the data
%     x0 = min(dist(force<0));
%
%     figure(idx(i))
%     hold on
%     title('FD curves fit to minimas')
%     xlim(xlimits);
%     ylim(ylimits);
%     xlabel('Distance (nm)');
%     ylabel('Force (pN)');
%     plot(10^9*(dist-x0),10^12*force,'.')
% end


figure
for filenumber = [1,2,3,5,6,10,12,13,14,16,18]
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    %%% Plot of the data
    x0 = min(dist(force<0));
    
    subplot(1,3,1)
    hold on
    title('FD curves fit to minimas')
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot((dist-x0),force,'.');
    
    if (filenumber ==1)
        subplot(1,3,2)
        hold on
        title('FD curves fit to minimas')
        xlim(xlimits);
        ylim(ylimits);
        xlabel('Distance (nm)');
        ylabel('Force (pN)');
        plot(dist,force,'.');
    end
end


for filenumber = [1,2,3,5,6,10,12,13,14,16,18]
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    %%% Plot of the data
    x0 = 1/5*sum(Lcs(:,1)-Lcs(:,filenumber));
    
    subplot(1,3,2)
    hold on
    title('FD curves fit to minimas')
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(10^9*(dist+x0),10^12*force,'.');
end