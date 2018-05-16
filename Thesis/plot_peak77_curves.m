% number of times each peak is present
% average force of each peak
% presence of next peak conditional on force intensity of current peak
% ...?
peaks = [34.4800,   54.5995,  77,  92.3607,  118.0434,  140.5817];
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
        xlim(xlimits);
        ylim(ylimits);
        
        plot(dist+deltas(tracenumber),force,'.');
        
        Xfit = linspace(0,peaks(3),1000);
        Ffit = fd(peaks(3), Xfit);
        plot(Xfit,Ffit);
    end
end

