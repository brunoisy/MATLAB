load('coal_mine')

N = 5000;
rho = 0.5; % mixing bad if rho small
d = 4;


for vartheta = [0.2 1 5]
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
    disp(theta_est)
    disp(t_est)
    disp(lambda_est)
    fprintf('__\n')
end


