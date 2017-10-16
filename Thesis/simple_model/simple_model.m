% this model generates data following a simple molecule model
rng(3)

global C
kb = 1.38064852e-23;
T  = 294;% 21°C
lp = 0.36*10^-9;
C  = kb*T/lp;


Lc = [72]*10^-9;%[33, 50, 92, 107, 130, 151]*10^-9; % Example of possible model parameters
maxLength = 200*10^-9;
n = 1024;
maxf = 150*10^-12;
sigmaNoise = 5*10^-12;

dist = linspace(0, maxLength, n);
force = zeros(1,n);

% generate forces from basic model
for i = 1:n
    force(i) = model_fun(Lc, dist(i), maxf);
end

% add noise
force = force + sigmaNoise*randn(1,n);

% figure
% plot(10^9*X, 10^12*F, '.'); 
% title('FD profile')
% xlabel('Distance (nm)');
% ylabel('Force (pN)');

save('data/MAT/data_model/curve_1.mat','dist', 'force')
