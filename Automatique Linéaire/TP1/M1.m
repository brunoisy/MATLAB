A = [-1, 1; -4, -2];
B = [0; 1];
C = [1, 0];
D = 0;

SYS = ss(A,B,C,D);
step(SYS)