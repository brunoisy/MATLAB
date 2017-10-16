load('Data-Homework-2.mat')
A = data.A;
b = data.b;
lambda = data.lambda;
x0 = data.x0;

N = 1000; % default number of iterations
epsilon = 0.01;
fOptimal = 23.673;
normX0MinusXOptimal = 13.79;% ||x_0 - x^*|| 

f = @(x)norm(A*x-b)^2+lambda*norm(x,1);


methods = {@subgradient, @smoothedGradient, @smoothedGradientAcc, @proximalGradient, @proximalGradientAcc};
names = {'Subgradient', 'Smoothed Gradient', 'Accelerated Smoothed Gradient', 'Proximal Gradient', 'Accelerated Proximal Gradient'};

%%% we now compute the theoretical upper bounds on convergence rates
n = length(x0);
G = 2*norm(A'*(A*x0-b))+sqrt(n)*lambda;
alpha = epsilon/(G^2);
L = 2*normest(A'*A);
mu = (-lambda*n+sqrt(lambda^2*n^2+4*n*normest(A'*A)*epsilon))/(2*normest(A'*A)*n);
LSmoothed = L+lambda/mu;


bndSubgr = @(N)normX0MinusXOptimal^2/(2*alpha*N) + alpha*G^2/2;
bndSmoothGr = @(N)lambda*mu*n/2+LSmoothed*normX0MinusXOptimal^2/(2*N);
bndSmoothGrAcc = @(N)lambda*mu*n/2+2*LSmoothed*normX0MinusXOptimal^2/(N+1)^2;
bndProxGr = @(N)L/(2*N)*normX0MinusXOptimal^2;
bndProxGrAcc = @(N)L/(2*N)*normX0MinusXOptimal^2;
bounds = {applyToColumns(bndSubgr,1:N+1), applyToColumns(bndSmoothGr,1:N+1), applyToColumns(bndSmoothGrAcc,1:N+1), applyToColumns(bndProxGr,1:N+1), applyToColumns(bndProxGrAcc,1:N+1)};

% plots (every method except interior point)

for i = 1:length(methods) 
    method = methods{i};
    x = method(A, b, lambda, x0, N, epsilon);
    fx = applyToColumns(f,x);
    figure
    semilogy(1:(N+1),fx-fOptimal, '-b') % true convergence
    hold on
    semilogy(1:(N+1),bounds{i}, '-r');    
    title(['Convergence behavior for', ' ', names{i}],'FontSize',16)
    ylabel('$|f(x_k) - f(x^*)|$','Interpreter','latex','Fontsize',16)
    xlabel('number of iterations k','Fontsize',16);
    legend('true convergence', 'theoretical bound on convergence');
    saveas(gcf,['plots/',names{i},'.eps']);
end


% plot for interior point
[~, fx] = interiorPoint(A, b, lambda);
figure
semilogy(1:length(fx),fx-fOptimal,'-b') % true convergence
hold on
title('Convergence behavior for interior point','FontSize',16)
xlabel('number of iterations k','Fontsize',16);
legend('true convergence', 'theoretical bound on convergence');