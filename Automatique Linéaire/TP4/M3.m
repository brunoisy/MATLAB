G = tf([1 1], [1 2 3]);
figure
hold on
for Kc = [1 2 3]
    C = tf(Kc*[1 3], [1 2]);
    Tr = feedback(C*G, 1);
    nyquist(Tr);
end
legend('1','2','3');