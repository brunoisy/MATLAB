sigma = 10;
b = 8/3;
r = 28;

f = @(t,w) [sigma*(w(2)-w(1));r*w(1)-w(2)-w(1)*w(3); w(1)*w(2)-b*w(3)];
w0 = [1; 0; 0];

[~,wt] = ode45(f,0:0.1:5,w0);
figure
hold on;
title('trajectoire pour condition initiale [1, 0, 0]');
xlabel('x');
ylabel('y');
zlabel('z');
plot3(wt(:,1),wt(:,2),wt(:,3))


delta0 = [0.001;0.001;0.001];
[Tout,wt2] = ode45(f,0:0.1:5,w0);
deltaT = wt2-wt;
plot(Tout, rowfun(@(x)norm(x), deltaT));