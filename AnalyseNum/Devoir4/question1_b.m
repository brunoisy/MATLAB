theta0 = [pi/8; pi/6];
ptheta0 = [0.5; 0.2];
n = 1000;
h = 1/n;

jacobF = matlabFunction(jacF(h));

%[thetaEx, pthetaEx] = euler_explicite(theta0, ptheta0, n, h);
%[thetaIm, pthetaIm] = euler_implicite(theta0, ptheta0, n, h, jacobF);
[thetaSym, pthetaSym] = euler_symplectique(theta0, ptheta0, n, h, jacobF);