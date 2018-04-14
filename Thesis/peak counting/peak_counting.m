addpath('LSQ fit')
addpath('alignment')


directory = 'data_4';
load(strcat('data/FD profiles/',directory,'.mat'),'Lcs','Lcs_lengths')
tracenumbers = %1:length(Lcs_lengths);%18, 26, 95 -  44, 53 %[1:17,19:25,27:43,45:52,54:94,96:100]
xlimits = [0, 150];
ylimits = [-300, 50];
% completeLc = [9,39,41,68,71,93,95,129,134,160,163,186,203,214,244,257,283,288,308,312,341,346,371,376,405,408]*.36;
% completeLc = [12,36,42,67,74,93,105,126,138,161,167,187,216,234,262,280,292,310,316,338,350,371,377,399]*.36;
% using 0.15 inliers in clustering n=5, we get Lc = 32.9618 53.0813 90.8425 116.5252 139.0635
% shifting by 1.5182, we get Lc = [34.4800   54.5995   92.3607  118.0434
% 140.5817]
templateLc = [34.4800   54.5995   92.3607  118.0434  140.5817];

updLcs = cell(1,length(Lcs_lengths));
deltas = zeros(1,length(Lcs_lengths));
allLcs = [];

for n = 2:8
    clusterLcs = cell2mat(Lcs(Lcs_lengths == n)')';
    for i = 1:length(clusterLcs(1,:))
        oktracenumbers = tracenumbers(Lcs_lengths == n);
        tracenumber = oktracenumbers(i);
         
        
        trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
        thisLc = clusterLcs(:,i)';
        
        [delta, npeaks] =  exhaustive_align(templateLc,thisLc,trace);% if npeaks==1??
        load(trace,'dist','force')
        dist = dist+delta;
        [updLc,~,~,~,~] = LSQ_fit_permissive(dist, force, 2, 5, 8, 4);
        updLcs{tracenumber} = updLc;
        deltas(tracenumber) = delta;
        allLcs = [allLcs, updLc];
        %end
    end
end
allLcs = sort(allLcs);

save('finalLcs.mat','updLcs','deltas','allLcs')

%%
thresh = 1.6;
mininliers = 20;


remaining = true(1,length(allLcs));
main_peaks = [];

[peak, inliers] = ransac_peak(allLcs, remaining, thresh, mininliers);
remaining(inliers) = false;
while ~isempty(peak)
    main_peaks = [main_peaks, peak];
    [peak, inliers] = ransac_peak(allLcs, remaining, thresh, mininliers);
    remaining(inliers) = false;
end

%%
xlimits = [0, 150];
ylimits = [-300, 50];
for tracenumber = tracenumbers
    Lc = updLcs{tracenumber};
    filteredLc = [];
    for Lci = Lc
        for Lcj = main_peaks
            if abs(Lci-Lcj)<thresh
                filteredLc = [filteredLc, Lcj];%Lcj?
            end
        end
    end
    
    figure('units','normalized','outerposition',[0 0 1 1]);
    colors = get(gca, 'colororder');
    hold on
%     title('plop')
    set(gca,'FontSize',22)
    xlim(xlimits);
    ylim(ylimits);
    xlabel('Distance (nm)');
    ylabel('Force (pN)');
    
    trace = strcat('data/MAT_clean/',directory,'/curve_',int2str(tracenumber),'.mat');
    load(trace,'dist','force')
    plot(dist+deltas(tracenumber), force, '.');
    
    for i=1:length(filteredLc)
        Xfit = linspace(0,filteredLc(i),1000);
        Ffit = fd(filteredLc(i), Xfit);
        plot(Xfit,Ffit,'Color','r');
    end
    saveas(gcf, strcat('images/plop/curve_',int2str(tracenumber),'.jpg'));
%     pause(1)
    close
end
