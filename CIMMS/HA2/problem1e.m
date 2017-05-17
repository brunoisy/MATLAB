addpath('acf')
load('coal_mine')

N = 5000;
vartheta = 2;
d = 4;

figure
hold on
for rho = [0.1 0.5 2.5]
    [theta, lambda, t] = post_f(coal_mine,d,N,vartheta,rho);
    
    autocorr0 = acf(theta',200);
    autocorr1 = acf(lambda(1,:)',200);
    autocorr2 = acf(lambda(2,:)',200);
    autocorr3 = acf(lambda(3,:)',200);
    autocorr4 = acf(lambda(4,:)',200);
    autocorr5 = acf(t(2,:)',200);
    autocorr6 = acf(t(3,:)',200);
    autocorr7 = acf(t(4,:)',200);
    
    subplot(4,2,1)
    hold on
    plot(autocorr0);
    subplot(4,2,2)
    hold on
    plot(autocorr1);
    subplot(4,2,3)
    hold on
    plot(autocorr2);
    subplot(4,2,4)
    hold on
    plot(autocorr3);
    subplot(4,2,5)
    hold on
    plot(autocorr4);
    subplot(4,2,6)
    hold on
    plot(autocorr5);
    subplot(4,2,7)
    hold on
    plot(autocorr6);
    subplot(4,2,8)
    hold on
    plot(autocorr7);
end
subplot(4,2,1)
title('autocorrelation of theta')
ylabel('correlation')
subplot(4,2,2)
title('autocorrelation of lambda_1')
subplot(4,2,3)
title('autocorrelation of lambda_2')
subplot(4,2,4)
title('autocorrelation of lambda_3')
subplot(4,2,5)
title('autocorrelation of lambda_4')
subplot(4,2,6)
title('autocorrelation of breakpoint t_1')
subplot(4,2,7)
title('autocorrelation of breakpoint t_2')
xlabel('time lag')
subplot(4,2,8)
title('autocorrelation of breakpoint t_3')
legend('rho = 0.1','rho = 0.5','rho = 2.5')
