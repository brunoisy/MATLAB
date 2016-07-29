m = 1;
k = 0.5;
alpha = 0.25;

A = [0, 1; -k/m, 0];
B = [0; 1/m];
C = [1, 0];
D = 0;

SYS = ss(A, B, C, D);
%response for the linearized model
step(SYS, 20)

hold on;
F = 1;
equ = @(t, x) [x(2); 1/m*(-alpha*x(2)^2-k*x(1)+F)];
[Tout, Yout] = ode45(equ, [0 20], [0;0]);
plot(Tout, Yout(:,1))

