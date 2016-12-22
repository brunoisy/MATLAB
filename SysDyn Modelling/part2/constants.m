k_1 = .1;
k_2 = .1;
k_3 = .1;
u = 0.1;
v = 1;
x0_1 = 15;
x0_2 = 5;
x0_3 = 5;
x0_4 = 5;

C = x0_3 + x0_4;
D = 2*x0_1 + 3*x0_2 + x0_4;

U = linspace(0,2,21);
V = linspace(0,0.2,21);


bifurcations(k_1, k_2, k_3, U, v, C, D)% with varying U
hold on
title('bifurcation for varying u','FontSize',22)
xlabel('x2','FontSize',18)
ylabel('x3','FontSize',18)
set(gca,'fontsize',18)
% 
% bifurcations(k_1, k_2, k_3, u, V, C, D)% with varying V
% hold on
% title('bifurcation for varying v','FontSize',22)
% xlabel('x2','FontSize',18)
% ylabel('x3','FontSize',18)
% set(gca,'fontsize',18)