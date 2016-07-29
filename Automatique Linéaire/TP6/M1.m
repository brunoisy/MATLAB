
for omega = [1 10]
    for sigma = [1 10]
        T = tf(omega^2, [1 2*omega*sigma omega^2]);
        figure
        bode(T)
    end
end
