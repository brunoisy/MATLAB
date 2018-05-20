addpath('LSQ fit')
filename = 'data/MAT_clean/data_4/curve_25.mat';
load(filename)

xlimits = [-10, 200];
ylimits = [-200, 50];

x0s = 85:105;
error = zeros(1,length(x0s));

for i = 1:length(x0s)
    [Lc, Xsel, Fsel, Xfirst, Xunfold, delta] = LSQ_fit_fd(dist, force, 4, false, 10, 10, 5, -x0s(i));
    error(i) = sum((Fsel - fd_multi([-x0s(i), Lc],Xsel,Xunfold)).^2)/length(Xsel);
end


figure
hold on
set(gca,'FontSize',22)
title('sensitivity of error to offset') 
xlabel('offset (nm)')
ylabel('MSE')
plot(x0s,error,'LineWidth',2)

