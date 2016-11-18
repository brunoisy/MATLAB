%%%%% Q2.2
load('hw3_datasets.mat')
x = input.dataset2.x';
y = input.dataset2.y';
alpha = 0.01;

for tMax = [1 10]
    [g, gamma, W] = algorithm1(x, y, alpha, tMax);
    figure
    hold on
    splineFun = makeSplineFun(x,g,gamma);
    plot(x,y,'*')% data points
    X = linspace(x(1),x(end), 1000);
    Yspline = arrayfun(splineFun,X);
    plot(X,Yspline)
    legend('data points', 'cubic spline')
end
[x';g';[0;gamma;0]']