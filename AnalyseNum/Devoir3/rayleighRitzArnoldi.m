function [eigVecRitz, eigValRitz] = rayleighRitzArnoldi(A, p, it)
% cette fonction utilise un processus de Rayleigh-Ritz couplé à
% l'algorithme d'arnoldi afin de trouver p couples de valeurs-vecteurs
% propres de A. La fonction utilise un Arnoldi itératif, et itère "it"
% fois.

n = length(A);
u1 = ones(n,1);
u1 = u1/norm(u1);

for k = 1:it  
    [B, U] = arnoldi(A, p, u1);
    [V, D] = eig(B);
    [~, pos] = max(diag(D));
    u1 = V(:, pos); %vecteur propre associé à la plus grande valeur propre
end

eigVecRitz = U*V;
eigValRitz = diag(D);
end