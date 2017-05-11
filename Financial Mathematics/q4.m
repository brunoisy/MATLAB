s0 = 100;
sigma = 0.2;
K = 100;
T = 0.5;
r = 0.03;
deltaT = 1/6;

u = exp(sigma*sqrt(deltaT));
d = exp(-sigma*sqrt(deltaT));

disc = 1/exp(r*deltaT);
q = (exp(r*deltaT)-d)/(u-d);

A = [1, 100; 1.005, 108.5076];
b = [3.8207; 0];
A\b;
95/1.05/exp(0.03/2)
95-exp(.03/4)*89.3526