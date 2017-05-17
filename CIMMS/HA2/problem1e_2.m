load('coal_mine')
rng(3)
N = 10000;
vartheta = 2;
d = 4;

figure
hold on
j=1;
for rho = [0.1 .5 2.5]
    [theta, lambda, t] = post_f(coal_mine,d,N,vartheta,rho);
    theta_est = mean(theta);
    lambda_est = zeros(1,d);
    for i=1:d
        lambda_est(i) = mean(lambda(i,:));
    end
    t_est = zeros(1,d+1);
    for i=1:d+1
        t_est(i) = mean(t(i,:));
    end
    
    
    % Plots
    subplot(3,1,j)
    j=j+1;
    stairs(t_est,[lambda_est, lambda_est(d)])
    
    ylabel('lambda')
    xlim([1851, 1963])
    theta_est
end
subplot(3,1,1)
hold on
title('value of parameters of posterior distribution for rho=0.1')
subplot(3,1,2)
hold on
title('value of parameters of posterior distribution for rho=0.5')
subplot(3,1,3)
hold on
title('value of parameters of posterior distribution for rho=2.5')
xlabel('time')