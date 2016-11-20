function [] = plotChamp(f1, f2, x11, x12, n, x21, x22, m)

x1Range = linspace(x11, x12, n);
x2Range = linspace(x21, x22, m);
[x1, x2] = meshgrid(x1Range, x2Range);
u = arrayfun(f1,x1,x2);
v = arrayfun(f2,x1,x2);

figure
hold on
title('champ de vecteurs')
quiver(x1,x2,u,v);
end

