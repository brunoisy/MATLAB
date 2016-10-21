% f1=1/(1+30x^2) -> f1'=-60x/(1+30x^2)^2
% f2=sin(pi*x) -> f2'=pi*cos(pi*x)

%%%%%%%%%%%%% question 1
n = 6;
x = linspace(-1,1,n+1);

y1 = 1./(1+30*x.^2);
y2 = sin(pi*x);

newtPoly1 = newtonInterpol(x, y1);
nevPoly1 = nevilleInterpol(x, y1);
newtPoly2 = newtonInterpol(x, y2);
nevPoly2 = nevilleInterpol(x, y2);


%%%%%%%%%%%%% question 2
%%% i)
nodalPoly = 1;
for i=1:n+1
    nodalPoly = conv(nodalPoly,[1 -x(i)]);
end

lambdas = ones(1,n+1);
for j=1:n+1
    for k=1:n+1
        if k ~= j
            lambdas(j) = lambdas(j)/(x(j)-x(k));
        end
    end
end

JacP = zeros(n+1,n+1);
for j=1:n+1
    JacP(j,:) = fliplr(deconv(nodalPoly*lambdas(j),[1 -x(j)]));
end

frobeniusNorm = norm(JacP,'fro');


%%% ii)
xStar = x(1)+(x(2)-x(1))/2;
yStar1 = polyval(newtPoly1, xStar);
yStar2 = polyval(newtPoly2, xStar);

% a)-b)
dpde_newt1 = zeros(n+1,1); % gradient of interpolation polynomial in epsilon variables
dpde_nev1 = zeros(n+1,1);
dpde_newt2 = zeros(n+1,1); 
dpde_nev2 = zeros(n+1,1);

for i = 1:n+1 % we approximate the gradient numerically
    eps = zeros(1,n+1); % perturbation
    eps(i) = 1;
    yPert1 = y1+eps;
    yPert2 = y2+eps;
    
    newPolyPert1 = newtonInterpol(x,yPert1);
    nevPolyPert1 = nevilleInterpol(x,yPert1);
    newPolyPert2 = newtonInterpol(x,yPert2);
    nevPolyPert2 = nevilleInterpol(x,yPert2);
    
    dpde_newt1(i) = polyval(newPolyPert1, xStar) - yStar1;
    dpde_nev1(i) = polyval(nevPolyPert1, xStar) - yStar1;
    dpde_newt2(i) = polyval(newPolyPert2, xStar) - yStar2;
    dpde_nev2(i) = polyval(nevPolyPert2, xStar) - yStar2;
end

norm(dpde_newt1)
norm(dpde_nev1)
norm(dpde_newt2)
norm(dpde_nev2)


% c)
dpde = zeros(n+1,1); % we find the true gradient thanks to the jacobian
for i = 1:n+1
    dpde(i) = polyval(fliplr(JacP(i,:)), xStar);
end
norm(dpde)


% %%%%%%%%%%%% question 3
X = linspace(-1, 1, 100);
Y1 = 1./(1+30*X.^2);
Y2 = sin(pi*X);

% doing interpolation again but with n=12
n = 12;
xbis = linspace(-1,1,n+1);
y1bis = 1./(1+30*xbis.^2);
y2bis = sin(pi*xbis);

% we'll only plot newton's interpolation polynomial since it's equal to neville's
newtPoly1bis = newtonInterpol(xbis, y1bis); 
newtPoly2bis = newtonInterpol(xbis, y2bis);

figure
subplot(1,2,1)
hold on
title('f1');
xlabel('X-axis')
ylabel('Y-axis')
plot(X,Y1)% real function f1
plot(x,y1,'*')% sample points n=6
plot(xbis,y1bis,'o')% sample points n=12
plotNewt1 = polyval(newtPoly1, X);
plot(X, plotNewt1)
plotNewt1bis = polyval(newtPoly1bis, X);
plot(X, plotNewt1bis)
legend('f1=1/(1+30x^2)','sample n=6','sample n=12','polynomial interpol n=6','polynomial interpol n=12');

subplot(1,2,2)
hold on
title('f2')
xlabel('X-axis')
ylabel('Y-axis')
plot(X,Y2)% real function f1
plot(x,y2,'*')% sample points n=6
plot(xbis,y2bis,'o')% sample points n=12
plotNewt2 = polyval(newtPoly2, X);
plot(X, plotNewt2)
plotNewt2bis = polyval(newtPoly2bis, X);
plot(X, plotNewt2bis)
legend('f2=sin(pi*x)','sample n=6','sample n=12','polynomial interpol n=6','polynomial interpol n=12');
saveas(gcf,'plot.jpg');

