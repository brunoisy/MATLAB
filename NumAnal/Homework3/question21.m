%%%%% Q2.1 a)
load('hw3_datasets.mat')
x = input.dataset1.x';
y = input.dataset1.y';
alpha = 0.1;
[g, gamma] = Reinsch(x,y,alpha);
% for i = 1:6
%    [x(2+8*(i-1):9+8*(i-1))';g(1+8*(i-1):8+8*(i-1))';gamma(1+8*(i-1):8+8*(i-1))']
% end


%%%%% Q2.1 b)
for alpha =[0.001 0.1 1]
    [g, gamma] = Reinsch(x,y,alpha);
    figure
    hold on
    splineFun = makeSplineFun(x,g,gamma);
    plot(x,y,'*')% data points
    X = linspace(x(1),x(end), 1000);
    Yspline = arrayfun(splineFun,X);
    plot(X,Yspline)
    title(sprintf('alpha = %.3f',alpha))
end