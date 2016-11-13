function funS2 = makeS2(x, y, sigma)
% This function returns a function handle funS2, which is the
% naturalCubicSpline of the interpolation points (x,y), when sigma contains
% the values of the second derivatives at these interpolation points.


n = length(x)-2;
h = x(2)-x(1);
alpha = (y(2:end) - 1/6*sigma(2:end)*h^2)/h;
beta  = (y(1:end-1) - 1/6*sigma(1:end-1)*h^2)/h;

    function y2 = s2(x2)
        i = ceil((x2+1)/2*(n+1));
        if i == 0; i = i+1; end % to avoid bug when x2==0
        y2 = (x(i+1)-x2)^3/(6*h)*sigma(i)+(x2-x(i))^3/(6*h)*sigma(i+1) + alpha(i)*(x2-x(i)) + beta(i)*(x(i+1)-x2);
    end

funS2 = @(x2) s2(x2);
end

