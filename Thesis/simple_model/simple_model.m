% this model generates data following a simple molecule model
rng(3)

load('constants.mat')

x0 = 10;%very high value! to test offset detection
Lc = [33, 50, 92, 107, 130, 151]; % Example of possible model parameters

maxLength = 200;
n = 1024;
fmax = 130;
sigmaNoise = 5;

dist = linspace(0, maxLength, n);
force = model_fun(dist, x0, Lc, fmax);


% add noise
force = force + sigmaNoise*randn(1,n);

figure
plot(dist, force, '.'); 
title('FD profile')
xlabel('Distance (nm)');
ylabel('Force (pN)');

save('data/MAT/data_model/curve_3.mat','dist', 'force')
