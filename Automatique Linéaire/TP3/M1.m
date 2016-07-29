G = tf(1,[1 2]);
i = 1;
figure
hold on
for Kc = [1,2,5]
    C = tf(Kc, 1);
    Tr = feedback(C*G, 1);
    step(Tr);
end
legend('Kc=1','Kc=2','Kc=5');

figure
hold on
for Kc = [1,2,5]
    C = tf(Kc, [1 0]);
    Tr = feedback(C*G, 1);
    step(Tr);
end
legend('Kc=1','Kc=2','Kc=5');
