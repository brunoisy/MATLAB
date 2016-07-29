
function [PiOfX] = findPolynoms(x, T)
% Calcule la valeur en x des polynomes orthogonaux succéssifs d'une matrice
% T tridiagonale symétrique.
%  PiOfX(i) = Pi-1(x)


[~,N]=(size(T));

PiOfX(1)=1; % p0 
PiOfX(2)=abs(x-T(1,1)); % p1

for i = 3:N+1  
    PiOfX(i)=(x - T(i-1,i-1))*PiOfX(i-1) - T(i-1,i-2)*T(i-1,i-2)*PiOfX(i-2);
end

end