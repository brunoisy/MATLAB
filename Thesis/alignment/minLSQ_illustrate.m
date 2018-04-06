templateLc = [33.4800   57.9600   94.3200  121.6800  143.6400];
Lc1 = [31,56,96];
Lc2 = [31,56,123];
Lc3 = [32,97,145];
Lc4 = [30,55,59];


figure
colors = get(gca, 'colororder');

subplot(2,2,1)
hold on
title('standard')
set(gca,'FontSize',22)
xlim([0, 150])
ylim([0,1])
xlabel('Distance (nm)')
set(gca,'ytick',[])
delta =  minLSQ_align(templateLc, Lc1);
for Lci = templateLc
    plot([Lci, Lci],0:1,'Color', colors(1,:))
end
for Lci = Lc1+delta
    plot([Lci, Lci],0:1,'Color', colors(2,:))
end




subplot(2,2,2)
hold on
title('1 missing peak')
set(gca,'FontSize',22)
xlim([0, 150])
ylim([0,1])
xlabel('Distance (nm)')
set(gca,'ytick',[])
delta =  minLSQ_align(templateLc, Lc2);
for Lci = templateLc
    plot([Lci, Lci],0:1,'Color', colors(1,:))
end
for Lci = Lc2+delta
    plot([Lci, Lci],0:1,'Color', colors(2,:))
end

subplot(2,2,3)
hold on
title('2 missing peaks')
set(gca,'FontSize',22)
xlim([0, 150])
ylim([0,1])
xlabel('Distance (nm)')
set(gca,'ytick',[])
delta =  minLSQ_align(templateLc, Lc3);
for Lci = templateLc
    plot([Lci, Lci],0:1,'Color', colors(1,:))
end
for Lci = Lc3+delta
    plot([Lci, Lci],0:1,'Color', colors(2,:))
end

subplot(2,2,4)
hold on
title('peak doubling')
set(gca,'FontSize',22)
xlim([0, 150])
ylim([0,1])
xlabel('Distance (nm)')
set(gca,'ytick',[])
delta =  minLSQ_align(templateLc, Lc4);
for Lci = templateLc
    plot([Lci, Lci],0:1,'Color', colors(1,:))
end
for Lci = Lc4+delta
    plot([Lci, Lci],0:1,'Color', colors(2,:))
end