function Lc = lsq_fit_fd(filename, xlimits, ylimits, k, offset, drawplot)
% k is the number of lsq+selection steps to apply
% if offset==true, we apply lsq offset optimization

load('constants.mat')
load(filename)

if nargin < 6
    drawplot = true; end
if nargin < 5
    offset = false; end
if nargin < 4
    k=1; end

x0 = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% First step : find local minimas of the FD profile.
%%% These will help us estimate the position of the crest
%%% The first estimations are the FD curves going through the minima
mins   = find_min(dist, force);

%%% We find the FD curves going through the minimas, parametrized by Lc,
%%% and merge Lc's that are too close
Lc = merge_Lc(find_Lc(mins, x0));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Plot
if drawplot
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
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% We can now select points that likely belong to the found Fd
%%% curves, apply least-square-fit to get a better estimate of Lc,
%%% and iterate

thresh = 10;% selection threshold


for j = 1:k
    %%% We select all the points that we will try to fit
    [Xsel, Fsel, Xfirst, Xunfold] = select_points(dist, force, x0, Lc, thresh);
    
    if offset == true
        x0Lc = lsqcurvefit(@(x0Lc,x) fd_multi(x0Lc,x,Xunfold), [x0, Lc], Xsel,  Fsel);
        x0 = x0Lc(1);
        Lc = x0Lc(2:end);
    else
        Lc = lsqcurvefit(@(Lc,x) fd_multi([x0,Lc],x,Xunfold), Lc, Xsel,  Fsel);
    end
    [Lc, Xfirst, Xunfold] = merge_Lc(Lc,Xfirst,Xunfold);
    
    
    if drawplot
        %%% Plot of the selected datapoints, and the estimated FD curves
        subplot(1,k+1,j+1)
        hold on
        if(offset == true)
            plot(0,0,'o')
            plot(x0,0,'o')
            legend('origin','offset')
            title('FD profile fit to minimum lsq with free offset')
        else
            title('FD profile fit to minimum lsq')
        end
        xlim(xlimits);
        ylim(ylimits);
        xlabel('Distance (nm)');
        ylabel('Force (pN)');

        for i=1:length(Lc)
            X = Xsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
            F =  Fsel(Xfirst(i)<=Xsel & Xsel<=Xunfold(i));
            Xfit = linspace(0,Lc(i),1000);
            Ffit = fd(Lc(i), Xfit);
            plot(X,F,'.');
            plot(Xfit+x0,Ffit);
        end
    end
end
end