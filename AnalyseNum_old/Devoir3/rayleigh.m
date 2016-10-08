function [ V,lambda ] = rayleigh( A,x0,n )
%x0 est un vecteur colonne non nul dans les complexes dont la norme=1
%A matrice carree d'ordre n dans les complexes
%n represente le nombre d'iterations voulues
%
%fonction renvoit le vecteur propre principale de A et la valeur propre
%associee en utilisant l'iteration du quotient de Rayleigh

x=x0;
m=length(A);
for k=0:n-1
    xconj=conj(x);
    a=xconj'*A*x;
    b=xconj'*x;
    shift = a/b;
    y=(A-shift*eye(m))\x;
    x=y/norm(y); 
end
V=x;
conjx = conj(x);
lambda = conjx'*A*x/(conjx'*x);
end
