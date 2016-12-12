b = 0.001;
d = 0.0011;
beta = 0.5; %?
gamma = 0.01;
delta = 0.01;
epsilon = 0.01;

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

T = 0:700;
[~,MEIR] = ode45(f,T,[Min;Ein;Iin;Rin]./Nin);

m = MEIR(:,1);
e = MEIR(:,2);
i = MEIR(:,3);
r = MEIR(:,4);
s = 1-m-e-i-r;

figure
hold on
title('proportion de la population dans les classes MSEIR')
plot(T,m);
plot(T,s);
plot(T,e);
plot(T,i);
plot(T,r);
ylabel('proportion de la population','FontSize',14)
xlabel('temps (jours)','FontSize',14)
legend('Enfants passivement immunisés','Susceptibles','Exposés','Infectés','Rétablis')

sigma = beta*epsilon/((gamma+d+q)*(epsilon+d+q));

mEq = (d+q)/(delta+d+q)*(1-1/sigma);
sEq = 1/sigma;
eEq = delta*(d+q)/((delta+d+q)*(epsilon+d+q))*(1-1/sigma);
iEq = epsilon*delta*(d+q)/((epsilon+d+q)*(delta+d+q)*(gamma+d+q))*(1-1/sigma);
rEq = epsilon*delta*gamma/((epsilon+d+q)*(delta+d+q)*(gamma+d+q))*(1-1/sigma);
