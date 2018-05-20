% number of times each peak is present
% average force of each peak
% presence of next peak conditional on force intensity of current peak
% ...?
peaks = [34.4800,   54.5995, 78,  92.3607,  118.0434,  140.5817];
xlimits = [-10, 150];
ylimits = [-200, 50];
n = length(peaks);
load('alignedWLC.mat')
thresh = 2;

% zero if corresponding trace doesn't contain peak, otherwise number of corresponding peak in trace
for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]
    Lc = permLcs{tracenumber};
    [minDiff, j] = min(abs(Lc-peaks(3)));
    if minDiff < thresh
        trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
        load(trace)
        
        figure
        hold on
        colors = get(gca, 'colororder');

        xlim(xlimits);
        ylim(ylimits);
        
        plot(dist+deltas(tracenumber),force,'.');
        
        
        
        templateLc = [34.4800   54.5995  92.3607  118.0434  140.5817];
        peak1 = 78;
        for i=1:length(templateLc)
            Xfit = linspace(0,templateLc(i),1000);
            Ffit = fd(templateLc(i), Xfit);
            h2 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
        end
        
        Xfit = linspace(0,peak1,1000);
        Ffit = fd(peak1, Xfit);
        plot(Xfit,Ffit,'Color',colors(5,:),'LineWidth',2);
        saveas(gcf, strcat('images/plop2/curve_',int2str(tracenumber),'.jpg'));
        close
    end
end

