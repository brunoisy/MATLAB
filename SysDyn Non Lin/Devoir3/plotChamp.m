function [] = plotChamp(f1, f2, x11, x12, n, x21, x22, m)

f = @(t,x)[f1(x(1),x(2));f2(x(1),x(2))];

x1Range = linspace(x11, x12, n);
x2Range = linspace(x21, x22, m);
[x1, x2] = meshgrid(x1Range, x2Range);
u = arrayfun(f1,x1,x2);
v = arrayfun(f2,x1,x2);

figure
hold on
title('champ de vecteurs et trajectoires','Fontsize',16)
xlabel('x_1','FontSize',14)
ylabel('x_2','FontSize',14)

quiver(x1,x2,u,v);

for i = 1:n
    for j = 1:m
        [~,X1X2] = ode45(f,0:0.1:5,[x1(i,j);x2(i,j)]);
        plot(X1X2(:,1),X1X2(:,2))
    end
end

end

