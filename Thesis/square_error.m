function E = square_error(Lc, X, F)
%SQUARE_ERROR Summary of this function goes here
%   Detailed explanation goes here
global C
E = 0;
for i = 1:length(X)
    E = E + (F(i)+C*(1/(4*(1-X(i)/Lc)^2)-1/4+X(i)/Lc))^2;
end

end

