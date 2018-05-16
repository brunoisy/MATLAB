addpath('LSQ fit')
% filename = 'data/MAT/data_2/curve_1.mat';
filename = 'data/MAT_clean/data_4/curve_5.mat';
load(filename)

xlimits = [-10, 200];
ylimits = [-200, 50];

x0s = 0:1:30;
error = zeros(1,length(x0s));

for i = 1:length(x0s)
    [Lc, Xsel, Fsel, Xfirst, Xunfold, delta] = LSQ_fit_fd(dist, force, 4, false, 10, 10, 5, -x0s(i));
    error(i) = sum((Fsel - fd_multi([-x0s(i), Lc],Xsel,Xunfold)).^2)/length(Xsel);%MSE
end
plot(x0s,error)

