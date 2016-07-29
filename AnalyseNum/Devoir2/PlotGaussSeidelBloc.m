% la fonction f de l'equation de Poisson
f = @(x,y)(4*cos(x^2+y^2)-4*sin(x^2+y^2)*(x^2+y^2));
% les differents parametres
n = 40;
h = 1/(n+1);
err = 0.0001;
% le systeme initial (question 1.b)
[A,b]=system_construction(f,n);
% le rearengement
brb = b_redblack(b);
Abr = redblack_ordering(n,A);
% la resolution
[x,e2] = GaussSeidel_blocs(n,err,Abr,brb);

% integration des valeurs limites
% et rearengement de la solution
% sous la forme d'une matrice U
U = zeros(n+2,n+2);
for i=2:n+1
    for j=2:n+1
        if(((mod(i-1,2)==0)&&(mod(j-1,2)==0))||((mod(i-1,2)~=0)&&(mod(j-1,2)~=0)))
            U(i,j) = x(floor(n^2/2)+ceil(((i-2)*n+j-1)/2));
        else
            U(i,j) = x(ceil(((i-2)*n+j-1)/2));
        end
    end
end
%et on plot...
X = h*[0:1:n+1];
Y = h*[0:1:n+1];
figure;
surf(X,Y,U);