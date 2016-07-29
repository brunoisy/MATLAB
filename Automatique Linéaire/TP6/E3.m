figure
hold on
for tau = [0.1 1 10]
    K = 1;
    theta = 1;
    G = tf(K, [tau 1], 'iodelay', theta);
    bode(G)
end
legend('tau = 0.1', 'tau=1', 'tau=10');