function newtPoly = makeNewtonPoly(x, y)
% Let x be interpolation points and y the interpolation values of a
% function to interpolate.
% This function returns the Newton interpolation polynomial as a function
% using a Horner scheme

n = length(x)-1;
newtonCoeff = zeros(n+1,n+1); %y0 to y01...n from formula (lower triangular)
newtonCoeff(:,1) = y;
for i=1:n
    for j=1:i
        newtonCoeff(i+1,j+1) = (newtonCoeff(i+1,j)-newtonCoeff(i,j))/(x(i+1)-x(i-j+1));
    end
end
divDiff = diag(newtonCoeff);% the divided differences

    function yVal = newNewtPoly(xVal)
        yVal = divDiff(n+1);
        for i=1:n
            yVal = yVal*(xVal - x(n+1-i))+divDiff(n+1-i);
        end
    end
    newtPoly = @(x) newNewtPoly(x);
end