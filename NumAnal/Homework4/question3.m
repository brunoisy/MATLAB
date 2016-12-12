pix = 200;
z = 2;

Y = imread('image.gif'); % 200 x 200 pixels
Y = reshape(Y,pix^2,1);

m1 = floor(pix/10); % /10 is arbitrary
m2 = floor(pix/10);

Ts = linspace(0,1,pix);
Us = linspace(0,1,pix);
tau = linspace(0,1,m1+2);
nu = linspace(0,1,m2+2);

%N = buildN(Ts, Us, tau, nu);
save('N.mat','N') % N is expensive to calculate

gStar = N\double(Y);
gStar = reshape(gStar, m1+2, m1+2);

TU.Te = linspace(0,1,z*pix);
TU.Ue = linspace(0,1,z*pix);
const.tau = tau;
const.nu = nu;

gfunc = g_evalBsplines(gStar,TU,const);

image(uint8(gfunc))