function [ V,lambda ] = puissance( A,x0,n )
%x0 est un vecteur colonne non nul dans les complexes 
%A matrice carree d'ordre n dans les complexes
%n represente le nombre d'iterations voulues
%
%fonction qui retourne le vecteur propre principale de A et la valeur
%propre associee en utilisant la methode de la puissance

x=x0;
for k=0:n-1
    Ax = A*x;
    ak = norm(Ax);
    x = Ax/ak;
end
V=x;
conjx = conj(x);
lambda = conjx'*A*x/(conjx'*x);
end
