function [minLambda, maxLambda, meanLambda] = varyDelta0(f, Tfinal, w0, n, tol)
% calcule l'exposant de Lyapunov pour des (n+1)^2 conditions initiales situées dans
% une sphère de rayon 0.001 autour de w0, avec un tolérance sur la méthode
% numérique de tol (tolérance par défaut si tol==0)

options = odeset('AbsTol',tol);
if(tol==0)
    [Tout,wt] = ode45(f,0:0.01:Tfinal,w0);
else
    [Tout,wt] = ode45(f,0:0.01:Tfinal,w0,options);
end

[x, y, z] = sphere(n); % creates 11x11 unit sphere
x = x/1000+w0(1);
y = y/1000+w0(2);
z = z/1000+w0(3);
lambdas = zeros(size(x,1),size(x,2));
for i = 1:size(x,1)
    for j = 1:size(x,2)
        w0Pert = [x(i,j);y(i,j);z(i,j)];
        if(tol==0)
            [Tout,wt2] = ode45(f,0:0.01:Tfinal,w0Pert);
        else
            [Tout,wt2] = ode45(f,0:0.01:Tfinal,w0Pert,options);
        end
        deltaT = wt2-wt;
        deltaTnorm = sqrt(deltaT(:,1).^2+deltaT(:,2).^2+deltaT(:,3).^2);
        [lambda, iCut, tCut]= LyapunovExponent(Tout,deltaTnorm);
        lambdas(i,j) = lambda;
    end
end
[minRow, ~] = min(lambdas);
[minLambda, ~] = min(minRow);

[maxRow, ~] = max(lambdas);
[maxLambda, ~] = max(maxRow);

meanLambda = mean(mean(lambdas));

figure
quiver3(x-w0(1),y-w0(2),z-w0(3),zeros(size(x,1),size(x,2)),zeros(size(x,1),size(x,2)),(lambdas-meanLambda))
hold on
title('lambda-meanLambda en fonction de delta(0)');
xlabel('x')
ylabel('y')
zlabel('z')
end