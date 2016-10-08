function [theta, ptheta] = euler_symplectique(theta0, ptheta0, n, h, jacobF)

theta = zeros(2, n+1);
ptheta = zeros(2, n+1);
theta(:, 1) = theta0;
ptheta(:, 1) = ptheta0;

for i = 1:n
    jacobF1 = @(x) jacobF(x(1), x(2),  ptheta(1, i), ptheta(2, i));
    % fonction matricielle d'ordre 4x4 a 2 inconnues
    %F1 = @(x) x - theta(:, i) - h*f1([x;ptheta(:, i)]);

    theta(:, i+1) = newton_raphson1(h, theta(:,i) , ptheta(:,i), jacobF1);
    ptheta(:, i+1) = ptheta(:, i) + h*f2([theta(:,i+1); ptheta(:, i)]);  
end

end
