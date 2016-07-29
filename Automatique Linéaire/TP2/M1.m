R = 1;
L = 0.1;
J = 2;
F = 2;
K = 4;

A = [-R/L, -K/L; K/J, -F/J];
B = [1/L; 0];
C = [K, 0];
D = [0; -1/J];

%G(s)
[Num, Den]= ss2tf(A, B, C, 0, 1);
SysTf = tf(Num, Den);
zerosG = roots(Num)
polesG = roots(Den)
step(SysTf)
hold on
%H(s)
[Num2, Den2]= ss2tf(A, D, C, 0, 1);
SysTf2 = tf(Num2, Den2);
zerosH = roots(Num2)
polesH = roots(Den2)
step(SysTf2)