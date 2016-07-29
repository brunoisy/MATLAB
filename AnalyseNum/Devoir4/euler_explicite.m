function [theta, ptheta] = euler_explicite(theta0, ptheta0, n, h)

y = zeros(4, n+1);
y(:,1) = [theta0;ptheta0];

for i = 1:n
    y(:, i+1) = y(:, i) + h*f(y(:, i));
end

theta = y([1 2], :);
ptheta = y([3 4], :);

end