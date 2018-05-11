
peak1 = 77;
peak2 = 108;
vars1 = zeros(1,40);
vars2 = zeros(1,40);

for n=1:40
    error = abs(allLcs-peak1);
    error = sort(error);
    closestn = error(1:n);
    vars1(n) = var(closestn);
    
    error = abs(allLcs-peak2);
    error = sort(error);
    closestn = error(1:n);
    vars2(n) = var(closestn);
end
figure
subplot(1,2,1)
hold on
set(gca,'FontSize',24)
title('L_c = 77')
plot(1:40, vars1,'LineWidth',2)
xlim([0,40]);
ylim([0,7]);
xlabel('number of inliers')
ylabel('variance of cluster')
xticks([0,10,20,30,40]);

subplot(1,2,2)
hold on
set(gca,'FontSize',24)
title('L_c = 108')
plot(1:40, vars2,'LineWidth',2)
xlim([0,40]);
ylim([0,7]);
xlabel('number of inliers')
ylabel('variance of cluster')
xticks([0,10,20,30,40]);
