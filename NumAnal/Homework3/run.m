% Q1 no plot? Q1.1 n+1 -> n+2 plutôt?

f = @(x) 1/(1+30*x^2);
n = 10;
x = linspace(-1,1,n+2)';
h = x(2)-x(1);

y = arrayfun(f,x);
sigma = naturalCubicSplines(x,y); %not convention from guidelines (g, gamma) but cleaner!

epsilon = -0.05 + 0.1*rand(n+2,1); % noise from uniform distribution on -0.05 0.05
yTilde = y + epsilon;
sigmaTilde = naturalCubicSplines(x,yTilde);
s2 = makeS2(x,yTilde,sigmaTilde);

%%% Plot
figure
hold on
X = linspace(-1,1,100);
Y = arrayfun(f,X);

plot(X,Y); % function f

plot(x, yTilde,'*'); % noisy Data

YCubicSplines = arrayfun(s2,X);
plot(X,YCubicSplines); % Interpolation splines
