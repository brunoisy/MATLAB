directory = 'data/MAT_clean/data_2/';
%directory = 'data/MAT_clean/data_1/good/';
%directory = 'data/MAT_clean/data_1/bad/';

load('constants.mat')

xlimits = [-10, 200];
ylimits = [-150, 25];

Lcs = cell(1, 18);%instead of zeros to avoid bad clustering
for filenumber = 1:18;%18%19 is problematic
    filename = strcat(directory,'curve_',int2str(filenumber),'.mat');
    load(filename);
    [Lc, ~, ~, ~, ~] = LSQ_fit_fd(dist,force);
    Lcs{filenumber} = Lc;
end
% Lcs
% idx = kmeans(Lcs', 5)
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
%     plot(dist-x0,force,'.')
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