function newtPoly = NewtonInterpol(x, y)
% interpolation using Newton's formula
n = length(x)-1;
newtonCoeff = zeros(n+1,n+1); %y0 to y01...n from formula (lower triangular)
newtonCoeff(:,1) = y;
for i=1:n
    for j=1:i
        newtonCoeff(i+1,j+1) = (newtonCoeff(i+1,j)-newtonCoeff(i,j))/(x(i+1)-x(i-j+1));
    end
end
newtonBasis = 1;
newtPoly = 0;
for i=1:n+1
    newtPoly = sum_poly(newtPoly,newtonCoeff(i,i)*newtonBasis);
    newtonBasis = conv(newtonBasis,[1, -x(i)]);
end

end

