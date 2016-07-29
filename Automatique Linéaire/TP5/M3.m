
for a = [-1 0 1]
    A = [0, 1; 1, -a];
    B = [0; 1];
    C = [1, 1];
    G = ss(A,B,C,0);
    Gz = zpk(G);
    figure
    bode(Gz);
end

A = [0, 1; 1, -1];
B = [0; 1];
C = [1, -1];
G = ss(A,B,C,0);
Gz = zpk(G);
figure
bode(Gz);
