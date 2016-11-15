% f = @(x) 1/(1+30*x^2);
% n = 12;
% x = linspace(-1,1,n+2)';
% 
% %%%%% Q1.1
% y = arrayfun(f,x);
% [g, gamma] = ncsInterpol(x,y);
% splineFun = makeSplineFun(x,y,gamma);
% 
% %%% Plot
% figure
% hold on
% X = linspace(-1,1,100);
% Y = arrayfun(f,X);
% 
% plot(X,Y); % function f
% plot(x, y,'*'); % interpolation points
% 
% Yspline = arrayfun(splineFun,X);
% plot(X,Yspline);
% legend('f = 1/(1+30x^3)','interpolation points','natural cubic splines')


% %%%%% Q1.2
% epsilon = -0.05 + 0.1*rand(n+2,1); % noise from uniform distribution on -0.05 0.05
% y2 = y + epsilon;
% [g2, gamma2] = ncsInterpol(x,y2);
% splineFun2 = makeSplineFun(x,y2,gamma2);
% 
% %%% Plot
% figure
% hold on
% X = linspace(-1,1,100);
% Y = arrayfun(f,X);
% 
% plot(X,Y); % function f
% plot(x, y2,'*'); % noisy Data
% 
% Yspline2 = arrayfun(splineFun2,X);
% plot(X,Yspline2);
% legend('f = 1/(1+30x^3)','y+eps','cubic splines')
% 
% 
% %%% gradient of x*
% 
% epsilon = 0.1;
% xStar = x(2)+(x(3)-x(2))/2;
% gradG = computeGradG(x,y,xStar,epsilon);
% norm(gradG); % formerly 2.0557, now 0.705
% 
% 
% %%% Q2.1
% load('hw3_datasets.mat')
% x = input.dataset1.x';
% y = input.dataset1.y';
% alpha = 0.1;
% [g, gamma] = Reinsch(x,y,alpha);
% norm(gamma)


% %%%%% Q2.2
% load('hw3_datasets.mat')
% x = input.dataset2.x';
% y = input.dataset2.y';
% alpha = 0.01;
% tMax = 5;
% [g, gamma, W] = algorithm1(x, y, alpha, tMax);
% 
% figure
% hold on
% splineFun = makeSplineFun(x,g,gamma);
% plot(x,y,'*')% data points
% X = linspace(x(1),x(end), 1000);
% Yspline = arrayfun(splineFun,X);
% plot(X,Yspline)
% legend('data points', 'cubic spline')    