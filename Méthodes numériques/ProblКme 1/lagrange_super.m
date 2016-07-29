function [uh] =  lagrange_super(x,X,U)
% Problème MATLAB 1 de Bruno Degomme, NOMA : 3972 13 00,
% Fait le 11/10/14


n = min(length(X),length(U));  % Evite un message d'erreur
den = ones(1,n); % Preallocation

for i=1:n
    for j=[1:(i-1) (i+1):n]
        den(i)=den(i)*(X(i)-X(j)); %% nous créons ainsi le dénominateur du membre bleu de l'équation
    end
end
blue = U./den; % nous avons maintenant le vecteur (ligne) bleu


red=ones(1,length(x)); % Preallocation
for j=1:length(x)% pour les m points x situés entre X0 et Xn
    for i=1:n
        red(j)=red(j).*(x(j)-X(i)); %% nous obtenons le vecteur (ligne) rouge
    end
end


A=zeros(n,length(x)); % Preallocation
for j=1:length(x)
    for i=1:n
        A(i,j)=1/(x(j)-X(i)); %% nous obtenons ainsi le membre en gris
    end
end
droite=blue*A;%% membre à droite du membre rouge
uh=red.*droite;

% la compléxité de l'approche de Benoit vaut O(mn) car il n'y a jamais plus
% de 2 boucles imbriquées

% Le problème avec cette téchnique se voit dans le calcul de la matrice A ( la partie grise de l'équation):
% si n'importe quel x vaut n'importe quel X, il y aura une division par 0
% est le programme plantera. L'utilisation de x = linspace(eps,5*(1-eps),m)
% permet d'éviter ce problème, puisque chaque x sera très proche d'un grand
% X (à une distance eps) mais jamais égale à un grand X.

% lorsque n>60, le polynome de Lagrange perd en stabilité aux limites, car
% l'erreur augmente à ces limites.
end

