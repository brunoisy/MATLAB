figure
hold on
for a = [-2 -1 0 1 2]
    G = tf(1, [1 (1+a) a]);
    nyquist(G)
end
legend('a=-2','a=-1','a=0','a=1','a=2');