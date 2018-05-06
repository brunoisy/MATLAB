nprocs = 1:16;

times1 = [0.109, 0.107, 0.061, 0.039, 0.030, 0.032, 0.026, 0.028, 0.021, 0.022, 0.020, 0.439, 0.796, 0.059, 0.043, 0.043];
iterations1 = 830;

times2 = [1.651, 0.852, 0.592, 0.468, 0.385, 0.324, 0.300, 0.261, 0.233, 0.244, 0.214, 0.229,0.443, 0.449,0.403,0.397];
iterations2 = 3120;

times3 = [25.095,12.791,8.618,6.547,5.476,4.590,4.012,3.596,3.250,2.978,2.807,3.618,5.405,5.229,4.525,4.771];
iterations3 = 11346;

times4 = [3.992,2.149, 1.457, 1.104, 0.957, 0.762, 0.801, 0.607, 0.538, 0.515, 0.645, 0.758, 0.895, 0.726,0.781,0.771];
iterations4 = 1898;

figure
subplot(2,2,1)
hold on
title("problem 1")
plot(nprocs, times1,'LineWidth',5)
xlabel("number of processes")
ylabel("execution time (s)");
set(gca,'FontSize',24)

subplot(2,2,2)
hold on
title("problem 2")
plot(nprocs, times2,'LineWidth',5)
xlabel("number of processes")
ylabel("execution time (s)");
set(gca,'FontSize',24)

subplot(2,2,3)
hold on
title("problem 3")
plot(nprocs, times3,'LineWidth',5)
xlabel("number of processes")
ylabel("execution time (s)");
set(gca,'FontSize',24)

subplot(2,2,4)
hold on
title("problem 4")
plot(nprocs, times4,'LineWidth',5)
xlabel("number of processes")
ylabel("execution time (s)");
set(gca,'FontSize',24)
