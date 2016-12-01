b = 0.01;
d = 0.01;
beta = 1/10; %?
gamma = 1/7;
delta = 1/180;
epsilon = 1/14;

q = b-d;
f = @(t,x) [(d+q)*(x(2)+x(3)+x(4))-delta*x(1); 
    beta*x(3)*(1-x(1)-x(2)-x(3)-x(4))-(epsilon+d+q)*x(2);  
    epsilon*x(2)-(gamma+d+q)*x(3);
    gamma*x(3)-(d+q)*x(4)];

Min = 100;
Sin = 500;
Ein = 10;
Iin = 50;
Rin = 100;
Nin = Min+Sin+Ein+Iin+Rin;

T = 0:100;
%N = N*e^((b-d)*T);
[~,MEIR] = ode45(f,T,[Min;Ein;Iin;Rin]./Nin);

m = MEIR(:,1);
e = MEIR(:,2);
i = MEIR(:,3);
r = MEIR(:,4);
s = 1-m-e-i-r;

figure
hold on
title('decomposition of the population into the MSEIR classes')
plot(T,m);
plot(T,s);
plot(T,e);
plot(T,i);
plot(T,r);
legend('Passively immune infants','Susceptibles','Exposed','Infectives','Recovered')%'FontSize',14