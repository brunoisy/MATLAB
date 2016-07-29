function [ numVar ] = numSignVar( X )
% Calcule le nombre de variation de signe du vecteur X
numVar=0;
[~,N]=size(X);

j=1;
for i= 1:N
    if(X(i) ~= 0)
        Y(j)=X(i);
        j=j+1;
    end
end

[~,M]=size(Y);
for k= 2:M
    if(Y(k) * Y(k-1) < 0)
        numVar=numVar+1;
    end
end

end

