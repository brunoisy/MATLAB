sec_peak = 77;

minDiff = zeros(1,100);
closestLc = zeros(1,100);
for tracenumber = 1:100
    Lc = exhLcs{tracenumber};
    if npeaks(tracenumber) >1
        [minDiff(tracenumber), i] = min(abs(Lc-sec_peak));
        closestLc(tracenumber) = Lc(i);
    else
        minDiff(tracenumber) = Inf;
    end
end

[~, I] = sort(minDiff);
closestLc = closestLc(I);

n = 50;
vars1 = zeros(1,n);

for n=1:n
    vars1(n) = var(closestLc(1:n));
end
figure
% subplot(1,2,1)
hold on
set(gca,'FontSize',24)
title('L_c = 77 nm')
plot(1:n, vars1,'LineWidth',2)
xlim([0,30]);
% ylim([0,7]);
xlabel('number of inliers')
ylabel('variance of cluster')
% xticks([0,10,20,30,40]);

% subplot(1,2,2)
% hold on
% set(gca,'FontSize',24)
% title('L_c = 107 nm')
% plot(1:40, vars2,'LineWidth',2)
% xlim([0,40]);
% ylim([0,7]);
% xlabel('number of inliers')
% ylabel('variance of cluster')
% % xticks([0,10,20,30,40]);
