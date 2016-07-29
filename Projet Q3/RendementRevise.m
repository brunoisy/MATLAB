function [] = RendementRevise(Pr,Tr)
% Pr=rendement reaction 
% Tr=Taux recyclage

Q=100; % réactifs
G=0; % produits
for i=1:10000
    G=G+Pr*Q;
    Q=(1-Pr)*Q*Tr;
end
RendementRevise=G/100
end

