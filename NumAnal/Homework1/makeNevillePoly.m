function nevPoly = makeNevillePoly(x, y)
% Let x be interpolation points and y the interpolation values of a
% function to interpolate.
% This function returns the Neville interpolation polynomial as a recursive
% function


n = length(x)-1;
    function yVal = P(i,j,xVal)
        if i==j 
            yVal = y(i);
        else
            yVal = ((xVal-x(i))*P(i+1,j,xVal)-(xVal-x(j))*P(i,j-1,xVal))/(x(j)-x(i));
        end
    end
nevPoly = @(x) P(1,n+1,x);

end

