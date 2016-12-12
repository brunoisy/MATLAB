sigma = 10;
b = 8/3;
r = 28;

f = @(t,w) [sigma*(w(2)-w(1));r*w(1)-w(2)-w(1)*w(3); w(1)*w(2)-b*w(3)];
w0 = [1; 0; 0];
Tfinal = 100;

%%%%% Question 1
[Tout,wt] = ode45(f,0:0.01:Tfinal,w0);
figure
hold on;
title('trajectoire pour condition initiale [1, 0, 0]','FontSize',16)
xlabel('x','FontSize',14)
ylabel('y','FontSize',14)
zlabel('z','FontSize',14)
plot3(wt(:,1),wt(:,2),wt(:,3))


%%%%% Question 2
delta0 = [0;0;0.001];
[~,wt2] = ode45(f,0:0.01:Tfinal,w0+delta0);
deltaT = wt2-wt;
deltaTnorm = sqrt(deltaT(:,1).^2+deltaT(:,2).^2+deltaT(:,3).^2);
figure
semilogy(Tout, deltaTnorm);
hold on;
title('$\|\delta\|$ as a function of time','Interpreter','latex','FontSize',16)
xlabel('time','FontSize',14)
ylabel('$\|\delta(t)\|$','Interpreter','latex','FontSize',14)



%%%%% Question 3
% on cherche tCut, apd duquel log(deltaTnorm) cesse de croitre
[lambda, iCut, tCut]= LyapunovExponent(Tout,deltaTnorm);
plot(Tout, [deltaTnorm(1)*10.^(lambda*Tout(1:iCut));mean(deltaTnorm(iCut:end))*ones(size(Tout,1)-iCut,1)]);


%%%%% Question 4
%[minLambda, maxLambda, meanLambda] = varyDelta0(f, Tfinal, w0, 20, 0);
 

%%%%% Question 5
%[minLambda, maxLambda, meanLambda] = varyDelta0(f, Tfinal, [0;5;0], 10, 0);


%%%%% Question 6
%[minLambda, maxLambda, meanLambda] = varyDelta0(f, Tfinal, w0, 10, 10^-2);

