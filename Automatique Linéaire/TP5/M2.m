G1 = tf([1 1], [1 2 -3]);
C = tf(1, [1 0]);
CG1 = G1*C;
rlocus(CG1)