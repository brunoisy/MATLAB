x1Range = linspace(-10, 10);
x2Range = linspace(-10, 10);
[x1, x2] = meshgrid(x1Range, x2Range);

y = zeros(100,100);
for i = 1:100
    for j=1:100
        y(i,j) = HuberFun([x1(i,j);x2(i,j)]);
    end
end

surf(x1,x2,y)