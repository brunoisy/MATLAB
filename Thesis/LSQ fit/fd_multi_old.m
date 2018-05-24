function [ F ] = fd_multi_old(deltaLcs, X, Xlast)
% make third arg optional

delta = deltaLcs(1);
Lcs = deltaLcs(2:end);

X = X+delta;
Xlast = Xlast+delta;
F = zeros(1,length(X));


for i = 1:length(Lcs)
    if i==1
        F(X<=Xlast(i)) = fd(Lcs(i), X(X<=Xlast(i)));
    else
        F(Xlast(i-1)<X & X<=Xlast(i)) = fd(Lcs(i), X(Xlast(i-1)<X & X<=Xlast(i)));
    end
end
end


