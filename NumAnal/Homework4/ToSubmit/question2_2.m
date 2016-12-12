m1 = 100;
m2 = 100;
p = 200;
q = 200;

Ts = linspace(0,1,p);
Us = linspace(0,1,q);
tau = linspace(0,1,m1+2);
nu = linspace(0,1,m2+2);

N = buildN(Ts,Us,tau,nu);