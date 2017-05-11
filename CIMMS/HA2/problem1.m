load('coal_mine')
d = 4;
N = 100;
vartheta = 2;
rho = 0.5;

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