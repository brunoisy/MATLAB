% revoir conventions gamma/sigma; n, m...

% f = @(x) 1/(1+30*x^2);
% n = 10;
% x = linspace(-1,1,n+2)';
% h = x(2)-x(1);
% 
% %%%%% Q1.1
% y = arrayfun(f,x);
% sigma = naturalCubicSplines(x,y);
% g = y(2:end-1);
% gamma = sigma(2:end-1);
% 
% 
% %%%%% Q1.2
% epsilon = -0.05 + 0.1*rand(n+2,1); % noise from uniform distribution on -0.05 0.05
% yTilde = y + epsilon;
% sigmaTilde = naturalCubicSplines(x,yTilde);
% s2 = makeS2(x,yTilde,sigmaTilde);
% 
% %%% Plot
% figure
% hold on
% X = linspace(-1,1,100);
% Y = arrayfun(f,X);
% plot(X,Y); % function f
% plot(x, yTilde,'*'); % noisy Data
% 
% YCubic = arrayfun(s2,X);
% plot(X,YCubic);
% legend('f = 1/(1+30x^3)','y+eps','cubic splines')
% 
% 
% %%% gradient of x*
% 
% epsilon = 0.1;
% xStar = x(1)+(x(2)-x(1))/2;% not x(2) x(3)?
% gradG = computeGradG(x,y,xStar,epsilon);
% norm(gradG);% formerly 2.0557, now 0.8471


%%%%% Q2.1
% load('hw3_datasets.mat')
% x = input.dataset1.x';
% y = input.dataset1.y';
% alpha = 0.1;
% [s, gamma] = Reinsch(x,y,alpha);
% g = s(2:end-1);
% norm(gamma)


% %%%%% Q2.2
x = input.dataset2.x';
y = input.dataset2.y';
alpha = 0.1;
tMax = 4;
[g, gamma, W] = algorithm1(x, y, alpha, tMax);
sigma = [0; gamma; 0];

figure
hold on
s2 = makeS2(x,g,sigma);
plot(x,y,'*')% data points
X = linspace(x(1),x(end), 1000);
Y = arrayfun(s2,X);
plot(X,Y)
legend('data points', 'cubic spline')







    
    
    
    
    
    