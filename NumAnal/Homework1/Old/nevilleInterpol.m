function nevPoly = NevilleInterpol(x, y)
% interpolation using Neville's formula
n = length(x)-1;
Ps = cell(n+1,n+1); % matrix containing the partly interpolating polynomials
Ps(:,1) = num2cell(y);
for i=1:n
    for j=1:i
        Ps{i+1,j+1} = (conv([1, -x(i-j+1)],Ps{i+1,j})-conv([1, -x(i+1)],Ps{i,j}))/(x(i+1)-x(i-j+1));
    end
end
nevPoly = Ps{n+1,n+1};

end

