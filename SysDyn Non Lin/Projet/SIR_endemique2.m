mu = 0.1;
beta = 3;
gamma = 1;

f = @(t,x) [mu-mu*x(1)-beta*x(1)*x(2); beta*x(1)*x(2)-gamma*x(2)-mu*x(2)];

figure
hold on
title('plan de phase SIR endemique pour sigma > 1')
xlabel('proportion susceptibles')
ylabel('proportion infectieux')
axis([-inf inf 0 inf])
plot(0:0.1:1,1-(0:0.1:1)) 


for Iinit = 0:0.1:1
    Sinit = 1-Iinit;
    [~,SIR] = ode45(f,0:0.01:100,[Sinit;Iinit]);
    plot(SIR(:,1),SIR(:,2));
end

