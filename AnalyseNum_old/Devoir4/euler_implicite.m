function [theta, ptheta] = euler_implicite(theta0, ptheta0, n, h, jacobF)
% Applique n itérations du schéma d'euler implicite. Newton-Raphson est 
% utilisé pour résoudre l'équation non linéaire à chaque itération.

y = zeros(4, n+1);
y(:, 1) = [theta0; ptheta0];
 
for i = 1:n
    %F = @(x) x - h*f(x) - y(:, i);
    y(:, i+1) = newton_raphson(h, y(:,i), jacobF);
end

theta = y([1 2], :);
ptheta = y([3 4], :);
end