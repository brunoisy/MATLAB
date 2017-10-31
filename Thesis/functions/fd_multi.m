function [ F ] = fd_multi(x0Lc, X, Xlast)
% make third arg optional


x0 = x0Lc(1);
Lc = x0Lc(2:end);

X = X-x0;
Xlast = Xlast-x0;
F = zeros(1,length(X));

for i = 1:length(Lc)
    if i==1
        F(0<X<=Xlast(i)) = fd(Lc(i), X(0<X<=Xlast(i))); % We might "loose" the first selected points (F=0)
    else
        F(Xlast(i-1)<X & X<=Xlast(i)) = fd(Lc(i), X(Xlast(i-1)<X & X<=Xlast(i)));
    end
end
end


