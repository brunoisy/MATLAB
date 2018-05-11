peak1 = 77;
peak2 = 108;
thresh1 = 3;
thresh2 = 3;

hasPeak1 = [];
hasPeak2 = [];

for tracenumber = [1:17,19:25,27:43,45:48,50:52,54:94,96:100]%tracenumbers
    if min(abs(updLcs{tracenumber}-peak1)) < thresh1
        hasPeak1 = [hasPeak1, tracenumber];
    end
    if min(abs(updLcs{tracenumber}-peak2)) < thresh2
        hasPeak2 = [hasPeak2, tracenumber];
    end
end

xlimits = [-10, 150];
ylimits = [-200, 50];
figure
hold on
title('secondary peak at L_c = 77 nm')
set(gca,'FontSize',24)
xlim(xlimits);
    ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
for tracenumber = hasPeak1
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace,'dist','force')
    plot(dist+deltas(tracenumber), force,'.','markers',4);
end

figure
hold on
title('secondary peak at L_c = 108 nm')

set(gca,'FontSize',24)
xlim(xlimits);
ylim(ylimits);
xlabel('Distance (nm)');
ylabel('Force (pN)');
for tracenumber = hasPeak2
    trace = strcat('data/MAT_clean/data_4/curve_',int2str(tracenumber),'.mat');
    load(trace,'dist','force')
    plot(dist+deltas(tracenumber), force,'.','markers',4);
end