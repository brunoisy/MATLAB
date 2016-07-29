function [uh] = hermite(n,X,U,dU,x)
% Auteur : Bruno Degomme
% date : le 24/10/14

% Commencons par trouver les coefficients de chaque terme du spline cubique
% de chaque intervalle, à partir des 4 équations qui définissent
% l'interpollation d'Hermite.
S=zeros(4,n);
for i=1:n
   A=[X(i)^3 X(i)^2 X(i) 1;X(i+1)^3 X(i+1)^2 X(i+1) 1;3*X(i)^2 2*X(i) 1 0;3*X(i+1)^2 2*X(i+1) 1 0];
   b=[U(i) U(i+1) dU(i) dU(i+1)];
   S(:,i)=A\b';
end

    
% Nous pouvons maintenant trouver la valeur de chaque point x dans
% l'interpollation d'Hermite.

uh=zeros(1,length(x)); % préallocation
for j=1:length(x)
    % extrapollation
    if x(j)<X(1)
        uh(j)=polyval(S(:,1),x(j));
    elseif x(j)>=X(n)
        uh(j)=polyval(S(:,n),x(j));
        
    % interpollation
    else
        for i=1:n
            if X(i+1)<=x(j)<X(i+2) % !!
                uh(j)=polyval(S(:,i),x(j));
                break
            end
        end
    end
end

end

