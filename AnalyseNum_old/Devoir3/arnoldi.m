function [ H, U ] = arnoldi( A, m, u1)
% cette fonction utilise l'algorithme d'Arnoldi pour renvoyer une base
% orthonormée U de l'espace de Krylov K_m(A, u1), ainsi que H  = U*AU, une
% matrice de Hessenberg.

n = length(A);
U = zeros(n,m);
U(:,1) = u1;
H = zeros(m,m);

for j = 1:m
        w = A * U(:,j);
        for i = 1:j
            H(i,j) = conj(U(:, i))'*w;
            w = w - H(i,j)*U(:,i);
        end
        if(j~=m)
            H(j+1,j) = norm(w);
            U(:,j+1) = w/H(j+1,j);
        end
end
end