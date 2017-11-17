directory = 'data/MAT/data_2/';
%directory = 'data/MAT/data_1/good/';
%directory = 'data/MAT/data_1/bad/';

load('constants.mat')

xlimits = [-10, 200];
ylimits = [-150, 25];

Lcs = cell(1, 18);%instead of zeros to avoid bad clustering
for filenumber = 1:18;%18%19 is problematic
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    
    x0 = 0;%min(dist(force<0));% from physical reality, this is our best guess of the value of x0
    k = 1;% number of iterations of lsq/selection
    
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
        
        Lc = lsqcurvefit(@(Lc,x)fd_multi([x0,Lc],x,Xlast), Lc, Xsel, Fsel);
        [Lc, Xfirst, Xlast] = merge_Lc(Lc,Xfirst,Xlast);
    end
    
    Lcs{filenumber} = Lc;
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
for filenumber = [1,2,3,5,6,10]%[1,2,3,5,6,10,12,13,14,16,18]
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    %%% Plot of the data
    x0 = 0;% min(dist(force<0));
    
    subplot(1,2,1)
    hold on
    title('FD profile')
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot((dist-x0),force,'.');
    
end


for filenumber = [1,2,3,5,6,10]%[1,2,3,5,6,10,12,13,14,16,18]
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename)
    %%% Plot of the data
    x0 = 1/5*sum(Lcs{1}-Lcs{filenumber});
    
    subplot(1,2,2)
    hold on
    title('FD profile with alignement')
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    plot(dist+x0,force,'.');
end

saveas(gcf, strcat('images/Alignement/figure_1','.fig'));
saveas(gcf, 'images/Alignement/figure_1','epsc');
saveas(gcf, strcat('images/Alignement/figure_1','.jpg'));