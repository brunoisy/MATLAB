T = [0;1];
U = [0;1];
m1 = 10;
m2 = 10;
tau = linspace(T(1),T(2),m1+2);
nu = linspace(U(1),U(2),m2+2);
d = tau(2)-tau(1);
e = nu(2)-nu(1);

delta4 = @(t) beta((t-tau(4))/d);
epsilon4 = @(u) beta((u-nu(4))/e);
tensorProd = @(t,u) delta4(t)*epsilon4(u);

t = linspace(T(1),T(2),200);
u = linspace(U(1),U(2),200);
[x1, x2] = meshgrid(t, u);
u = arrayfun(tensorProd,x1,x2);

figure
hold on
surf(x1,x2,u)
xlabel('T')
ylabel('U')
title('tensor product $\delta_4\otimes\epsilon_4$','Interpreter','latex', 'Fontsize', 16)