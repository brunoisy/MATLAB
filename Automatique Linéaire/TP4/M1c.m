K = 1;
tau = 5;
theta = 2;
G = tf(1, [tau 1], 'iodelay', theta); 

figure
hold on
for Kc = [0.9 1.2];
    tauI = tau;
    C = tf(Kc*[tauI 1], [tauI 0]);
    Tr = feedback(C*G, 1);
    step(Tr);
end
legend('Kc Taylor', 'Kc Padé');