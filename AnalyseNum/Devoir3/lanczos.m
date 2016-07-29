function [ H, U ] = lanczos( A, m, u1)
% Pour utiliser cette fonction, il faut que A soit hermitienne !
% cette fonction utilise l'algorithme de Lanczos hermitienne pour renvoyer une base
% orthonormée U de l'espace de Krylov K_m(A, u1), ainsi que H  = U*AU, une
% matrice tridiagonale symétrique.

n = length(A);
U = zeros(n,m);
U(:,1) = u1;
u0 = zeros(n,1);

beta = zeros(m,1);
alpha = zeros(m,1);

for j = 1:m
        if(j==1)  
            w = A*U(:,j) - beta(j)*u0;
        else
            w = A*U(:,j) - beta(j)*U(:,j-1);
        end
        alpha(j) = conj(U(:,j))'*w;
        w = w - alpha(j)*U(:,j);
        if(j ~= m)
            beta(j+1) = norm(w);
            U(:,j+1) = w/beta(j+1);
        end
end

H = diag(alpha) + diag(beta(2:m), 1) + diag(beta(2:m), -1); 

end