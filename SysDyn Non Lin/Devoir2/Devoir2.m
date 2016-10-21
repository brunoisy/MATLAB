a = 2;
b = 3;
f1 = @(t,x) a + b*x^2;
t1 = pi/sqrt(a*b);

% [T1, X1] = ode15s(f1, [0 t1], -5*10^12);
% figure 
% hold on
% ylim([-10 10])
% plot(T1,X1);

f2 = @(t,x) a*(exp(x)-x*exp(x)+x^3*exp(x))+(a/2+b)*x^2;
[T2, X2] = ode15s(f2, [0 t1],-5*10^12);
figure 
hold on
ylim([-10 10])
plot(T2,X2);
% explose en 1 sec au lieu de 1.2825