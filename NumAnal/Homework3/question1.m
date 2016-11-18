f = @(x) 1/(1+30*x^2);
n = 10;
x = linspace(-1,1,n+2)';

%%%%% Q1.1
y = arrayfun(f,x);
[g, gamma] = ncsInterpol(x,y);
splineFun = makeSplineFun(x,y,gamma);

%%% Plot
figure
hold on
X = linspace(-1,1,100);
Y = arrayfun(f,X);

plot(X,Y); % function f
plot(x, y,'*'); % interpolation points

Yspline = arrayfun(splineFun,X);
plot(X,Yspline);
legend('f = 1/(1+30x^2)','observations','g_n')


%%%%% Q1.2
epsilon = -0.05 + 0.1*rand(n+2,1); % noise from uniform distribution on -0.05 0.05
y2 = y + epsilon;
[g2, gamma2] = ncsInterpol(x,y2);
splineFun2 = makeSplineFun(x,y2,gamma2);

%%% Plot
figure
hold on
X = linspace(-1,1,100);
Y = arrayfun(f,X);

plot(X,Y); % function f
plot(x, y2,'*'); % noisy Data

Yspline2 = arrayfun(splineFun2,X);
plot(X,Yspline2);
legend('f = 1/(1+30x^2)','noisy observations','g_n')


%%% gradient of x*

epsilon = 0.01;
xStar = x(2)+(x(3)-x(2))/2;
gradG = computeGradG(x,y,xStar,epsilon);
norm(gradG);