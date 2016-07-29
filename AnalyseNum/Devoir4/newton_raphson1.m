function [ X ] = newton_raphson1(h, b, c, jacobF1)
% F1 est une fonction (non linéaire) vectorielle d'ordre 2 à 2 inconnues 
% dont nous cherchons une racine
% jacobF la jacobienne de F
% renvoie X, solution approchée de F(X) = 0, trouvé en it itérations

it = 5;
X = ones(2,1);

for i = 1:it
    jFx = jacobF1(X);
    X = jFx(1:2, 1:2)\(-(X - b - h*f1([X;c]))) + X;
end

end

