f = @(x,y)(4*cos(x^2+y^2)-4*sin(x^2+y^2)*(x^2+y^2));
n = 5;
h = 1/(n+1);
err = 0.005;
[A b x G] = GaussSeidel2(f,n,err); %calcul de la solution numerique
lambdas=eigs(A);
lambdas2=eigs(G);
U = zeros(n+2,n+2);

for i=1:n+2
    for j=1:n+2
        U(i,j)=x((i-1)*(n+2)+j);
    end
end

%et on plot...
X = 0:h:1;
Y = 0:h:1;
figure;
surf(X,Y,U) %plot la solution numerique