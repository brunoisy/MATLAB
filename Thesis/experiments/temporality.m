load('data/MAT_clean/data_2/curve_2.mat');

figure
hold on
xlimits = [-10, 200];
ylimits = [-150, 200];
xlim(xlimits);
ylim(ylimits);
n = 20;
colors = cell(1,n);
for i=1:n
   colors{i} = (i-1)/(n+3)*ones(1,3); 
end
% colors = ['.y', '.m', '.c', '.r', '.g','.b','.k'];

for i = 1:length(dist)
    plot(dist(i), force(i),'.','Color', colors{mod(i, n)+1})
end
