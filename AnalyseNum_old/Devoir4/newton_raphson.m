function [ X ] = newton_raphson(h, b, jacobF)
% F est une fonction (non linéaire) vectorielle d'ordre 4 à 4 inconnues 
% dont nous cherchons une racine
% jacobF la jacobienne de F
% renvoie X, solution approchée de F(X) = 0, trouvé en it itérations

it = 10;
X = ones(4,1);

for i = 1:it
    X = jacobF(X(1), X(2), X(3), X(4))\(-(X - h*f(X) - b)) + X;
end

end