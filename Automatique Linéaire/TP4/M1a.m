G = tf([1 1], [1 2 -3]);
figure
hold on
for Kc = [6.1 7 10]
    C = tf(Kc, [1 0]);
    Tr = feedback(C*G, 1);
    step(Tr)
end
legend('KC=6.1', 'Kc=7', 'Kc=10');