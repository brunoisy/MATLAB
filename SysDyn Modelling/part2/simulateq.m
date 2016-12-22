function simulateq(k_1, k_2, k_3, u, v, C, D)
figure
for x0_3 = linspace(.01, C, 4)
    x0_4 = C-x0_3;
    for x0_2 = linspace(.01,(D-x0_4)/6,4)
        x0_1 = (D-x0_4-3*x0_2)/2;
        addsim(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4);
    end
end
addeq(k_1, k_2, k_3, u, v, C, D, true, 10);
xlabel('x_2');
ylabel('x_3');
end
