theta0 = [pi/2; 0];
ptheta0 = [0; 0];
n = 5000;
h = 5*10^-4;

jacobF = matlabFunction(jacF(h));

[thetaEx, pthetaEx] = euler_explicite(theta0, ptheta0, n, h);
[thetaIm, pthetaIm] = euler_implicite(theta0, ptheta0, n, h, jacobF);
[thetaSym, pthetaSym] = euler_symplectique(theta0, ptheta0, n, h, jacobF);
[T,Y] = ode45(@fode,[0 (n.*h)],[pi/2; 0; 0; 0]);
thetaOde = [(Y(:,1))'; (Y(:,2))'];
pthetaOde = [(Y(:,3))'; (Y(:,4))'];

x = linspace(0, 5, n+1);
HEx = (0.5.^2.*pthetaEx(1,:).*pthetaEx(1,:)+2.*0.3.*0.3.*pthetaEx(2,:).*pthetaEx(2,:)-2.*0.3.*0.5.*pthetaEx(1,:).*pthetaEx(2,:).*cos(thetaEx(1,:)-thetaEx(2,:)))/(2.*0.3.*0.3.*0.5.*0.5.*(1+sin(thetaEx(1,:)-thetaEx(2,:)).^2))-9.81.*0.5.*cos(thetaEx(2,:))-2.*9.81.*0.3.*cos(thetaEx(1,:));
HIm = (0.5.^2.*pthetaIm(1,:).*pthetaIm(1,:)+2.*0.3.*0.3.*pthetaIm(2,:).*pthetaIm(2,:)-2.*0.3.*0.5.*pthetaIm(1,:).*pthetaIm(2,:).*cos(thetaIm(1,:)-thetaIm(2,:)))/(2.*0.3.*0.3.*0.5.*0.5.*(1+sin(thetaIm(1,:)-thetaIm(2,:)).^2))-9.81.*0.5.*cos(thetaIm(2,:))-2.*9.81.*0.3.*cos(thetaIm(1,:));
HSym = (0.5.^2.*pthetaSym(1,:).*pthetaSym(1,:)+2.*0.3.*0.3.*pthetaSym(2,:).*pthetaSym(2,:)-2.*0.3.*0.5.*pthetaSym(1,:).*pthetaSym(2,:).*cos(thetaSym(1,:)-thetaSym(2,:)))/(2.*0.3.*0.3.*0.5.*0.5.*(1+sin(thetaSym(1,:)-thetaSym(2,:)).^2))-9.81.*0.5.*cos(thetaSym(2,:))-2.*9.81.*0.3.*cos(thetaSym(1,:));
HOde = (0.5.^2.*pthetaOde(1,:).*pthetaOde(1,:)+2.*0.3.*0.3.*pthetaOde(2,:).*pthetaOde(2,:)-2.*0.3.*0.5.*pthetaOde(1,:).*pthetaOde(2,:).*cos(thetaOde(1,:)-thetaOde(2,:)))/(2.*0.3.*0.3.*0.5.*0.5.*(1+sin(thetaOde(1,:)-thetaOde(2,:)).^2))-9.81.*0.5.*cos(thetaOde(2,:))-2.*9.81.*0.3.*cos(thetaOde(1,:));

figure
plot(x,thetaEx(1,:),'b--',x,thetaIm(1,:),'g-.',x,thetaSym(1,:),'r',T./(n*h/5),thetaOde(1,:),'k');
figure
plot(x,thetaEx(2,:),'b--',x,thetaIm(2,:),'g-.',x,thetaSym(2,:),'r',T./(n*h/5),thetaOde(2,:),'k');
figure
plot(x,pthetaEx(1,:),'b--',x,pthetaIm(1,:),'g-.',x,pthetaSym(1,:),'r',T./(n*h/5),pthetaOde(1,:),'k');
figure
plot(x,pthetaEx(2,:),'b--',x,pthetaIm(2,:),'g-.',x,thetaSym(2,:),'r',T./(n*h/5),pthetaOde(2,:),'k');
figure
plot(x,HEx,'b--',x,HIm, 'g-.', x, HSym,'r',T./(n*h/5),HOde,'k');