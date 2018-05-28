peak1 = 77;
% peak2 = 107;
thresh1 = 1.5;
hasPeak1 = [];
hasPeak2 = [];

for tracenumber = 1:100%[1:17,19:25,27:43,45:48,50:52,54:94,96:100]%tracenumbers
    if npeaks(tracenumber) >=1
        if min(abs(exhLcs{tracenumber}-peak1)) < thresh
            hasPeak1 = [hasPeak1, tracenumber];
        end
    end

end

xlimits = [-10, 150];
ylimits = [-200, 50];
figure
hold on
colors = get(gca, 'colororder');

title('L_c = 78 nm')
set(gca,'FontSize',24)
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');

for tracenumber = hasPeak1
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace,'dist','force')
        plot(dist+deltas(tracenumber), force,'.','Color',colors(1,:),'markers',7);
    
    
    
    
    
end

templateLc = [34.4800   54.5995  92.3607  118.0434  140.5817];
for i=1:length(templateLc)
    Xfit = linspace(0,templateLc(i),1000);
    Ffit = fd(templateLc(i), Xfit);
    h2 = plot(Xfit,Ffit,'Color',colors(7,:),'LineWidth',2);
end

Xfit = linspace(0,peak1,1000);
    Ffit = fd(peak1, Xfit);
plot(Xfit,Ffit,'Color',colors(5,:),'LineWidth',2);
