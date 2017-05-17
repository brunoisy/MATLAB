load('coal_mine')
rng(3)
N = 5000;
vartheta = 2;
rho = 0.5;

figure
hold on
for d=1:4
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
    subplot(4,1,d)
    stairs(t_est,[lambda_est, lambda_est(d)])
    
    ylabel('lambda')
    xlim([1851, 1963])
    theta_est
end
subplot(4,1,1)
hold on
title('value of parameters of posterior distribution for d=1')
subplot(4,1,2)
hold on
title('value of parameters of posterior distribution for d=2')
subplot(4,1,3)
hold on
title('value of parameters of posterior distribution for d=3')
subplot(4,1,4)
hold on
title('value of parameters of posterior distribution for d=4')
xlabel('time')