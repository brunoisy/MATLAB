function [ V,lambda ] = iteration_inverse(A, x0, shift, n)
%x0 est un vecteur colonne non nul dans les complexes 
%A matrice carree d'ordre n dans les complexes
%n represente le nombre d'iterations voulues
%shift appartient aux complexes
%
%fonction renvoit le vecteur propre principale de A et la valeur propre
%associee en utilisant la methode de l'iteration inverse

x = x0;
m = length(A);
y = zeros(20,1);
for k=0:n-1
    y=(A-shift*eye(m))\x;
    x=y/norm(y);
end
V=x;
conjx = conj(x);
lambda = conjx'*A*x/(conjx'*x);
end

