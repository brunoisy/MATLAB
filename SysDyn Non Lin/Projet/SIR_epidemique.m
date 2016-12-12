r = 0.0001;
a = 0.03;
p = 1;
N = 1000;
f = @(t,x) [-r*x(1)^p*x(2); r*x(1)^p*x(2)-a*x(2); a*x(2)];


Rinit = 0;
figure
hold on
title('plan de phase SIR epidemique')
xlabel('susceptibles')
ylabel('infectieux')
axis([-inf inf 0 inf])
plot(1:N,N-(1:N)) % population totale
plot(a/r*ones(1,N),1:N)%
for Iinit = 1:100:N %0:100:(N-Rinit)
    Sinit = N-Rinit-Iinit;
    [~,SIR] = ode45(f,0:10000,[Sinit;Iinit;Rinit]);
    plot(SIR(:,1),SIR(:,2));
end
legend('S+I=N','1/sigma')