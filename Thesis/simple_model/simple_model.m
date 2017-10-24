% this model generates data following a simple molecule model
rng(3)

kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;

x0 = 10*10^-9;%very high value! to test offset detection
Lc = [33, 50, 92, 107, 130, 151]*10^-9; % Example of possible model parameters

maxLength = 200*10^-9;
n = 1024;
fmax = 130*10^-12;
sigmaNoise = 0;%5*10^-12;

dist = linspace(0, maxLength, n);
force = model_fun(dist, x0, Lc, fmax);


% add noise
force = force + sigmaNoise*randn(1,n);

figure
plot(10^9*dist, 10^12*force, '.'); 
title('FD profile')
xlabel('Distance (nm)');
ylabel('Force (pN)');

save('data/MAT/data_model/curve_2.mat','dist', 'force')
