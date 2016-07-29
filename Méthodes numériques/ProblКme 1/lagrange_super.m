function [uh] =  lagrange_super(x,X,U)
% Probl�me MATLAB 1 de Bruno Degomme, NOMA : 3972 13 00,
% Fait le 11/10/14


n = min(length(X),length(U));  % Evite un message d'erreur
den = ones(1,n); % Preallocation

for i=1:n
    for j=[1:(i-1) (i+1):n]
        den(i)=den(i)*(X(i)-X(j)); %% nous cr�ons ainsi le d�nominateur du membre bleu de l'�quation
    end
end
blue = U./den; % nous avons maintenant le vecteur (ligne) bleu


red=ones(1,length(x)); % Preallocation
for j=1:length(x)% pour les m points x situ�s entre X0 et Xn
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
droite=blue*A;%% membre � droite du membre rouge
uh=red.*droite;

% la compl�xit� de l'approche de Benoit vaut O(mn) car il n'y a jamais plus
% de 2 boucles imbriqu�es

% Le probl�me avec cette t�chnique se voit dans le calcul de la matrice A ( la partie grise de l'�quation):
% si n'importe quel x vaut n'importe quel X, il y aura une division par 0
% est le programme plantera. L'utilisation de x = linspace(eps,5*(1-eps),m)
% permet d'�viter ce probl�me, puisque chaque x sera tr�s proche d'un grand
% X (� une distance eps) mais jamais �gale � un grand X.

% lorsque n>60, le polynome de Lagrange perd en stabilit� aux limites, car
% l'erreur augmente � ces limites.
end

