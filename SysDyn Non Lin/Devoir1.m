%%% question 1

w = 2;
[x, y] = meshgrid(-1:.1:1, -1:.1:1);
u = y;
v = -w^2*x;

figure
hold on
title('champ vecteur')
quiver(x,y,u,v);
saveas(gcf,'Images/champ_vecteur.jpg');


%%% question 2 -> graphique 3D? faut il laisser l'erreur numérique?

n = 10000;
h = 0.01;
t = 0:0.01:100;
A = [0, 1; -w^2, 0];
F = @(X) A*X;

x0 = [2; 0]; % condition initiale
X = EulerExplicite(F, x0, n, h);
x1 = X(1,:);
x2 = X(2,:);

x0bis = [0.5; 0.5];
Xbis = EulerExplicite(F, x0bis, n, h);
x1bis = Xbis(1,:);
x2bis = Xbis(2,:);

figure
hold on
title('trajectoires')
plot3(x1,x2,t);
plot3(x1bis,x2bis,t);
xlabel('x1')
ylabel('x2')
zlabel('t');
saveas(gcf,'Images/trajectoires.jpg');


figure
hold on
title('orbites')
plot(x1,x2);
plot(x1bis,x2bis);
saveas(gcf,'Images/orbites.jpg');


%%% question 3

x0 = [2; 0]; % condition initiale
X = EulerSymplectique(x0, n, h, w);
x1 = X(1,:);
x2 = X(2,:);

x0bis = [0.5; 0.5];
Xbis = EulerSymplectique(x0bis, n, h, w);
x1bis = Xbis(1,:);
x2bis = Xbis(2,:);

figure
hold on
title('orbites avec symplectique');
plot(x1,x2);
plot(x1bis,x2bis);
saveas(gcf,'Images/orbites_symp.jpg');
