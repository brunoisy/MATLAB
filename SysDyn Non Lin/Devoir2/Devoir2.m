a = 2;
b = 3;
t = pi/sqrt(a*b);

f1 = @(t,x) a*(exp(x)-x*exp(x))+(a/2+b)*x^2;
[T1, X1] = ode15s(f1, [0 t],-5*10^12);
figure 
hold on
ylim([-10 10])
plot(T1,X1);
xlabel('time')
ylabel('x')

f2 = @(t,x) a*(exp(x)-x*exp(x)+x^3*exp(x))+(a/2+b)*x^2;
[T2, X2] = ode15s(f2, [0 t],-5*10^12);
figure 
hold on
ylim([-10 10])
plot(T2,X2);
xlabel('time')
ylabel('x')