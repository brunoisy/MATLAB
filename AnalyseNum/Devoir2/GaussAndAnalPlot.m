f = @(x,y)(4*cos(x^2+y^2)-4*sin(x^2+y^2)*(x^2+y^2));
n = 40;
h = 1/(n+1);
err = 0.000005;
x = GaussSeidel(f,n,err); %calcul de la solution numerique
%U2 = Analytic(f,n); %calcul de la solution analytique
%imposition des conditions aux limites

U = zeros(n+2,n+2);
U3 = zeros(n+2,n+2);
for i=2:n+1
    for j=2:n+1
        U(i,j)=x((i-2)*n+j-1);
        %U3(i,j)=U2(i-1,j-1);
    end
end
%et on plot...
X = h*[0:1:n+1];
Y = h*[0:1:n+1];
figure;
%surf(X,Y,U3) %plot la solution analytique
figure;
surf(X,Y,U) %plot la solution numerique