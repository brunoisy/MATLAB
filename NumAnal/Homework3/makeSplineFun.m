function splineFun = makeSplineFun(x, y, gamma)
% This function returns a function handle funS2, which is the
% naturalCubicSpline of the interpolation points (x,y), when sigma contains
% the values of the second derivatives at these interpolation points.
% (this approach of writting things (with alpha and beta) comes from the
% book, P299)

n = length(x)-2;
h = x(2:end) - x(1:end-1);
sigma = [0; gamma; 0];
alpha = (y(2:end) - 1/6*sigma(2:end).*h.^2)./h;
beta  = (y(1:end-1) - 1/6*sigma(1:end-1).*h.^2)./h;

    function y2 = s(x2)
        i = ceil((x2+1)/2*(n+1));
        if i == 0; i = i+1; end % to avoid bug when x2==0
        y2 = (x(i+1)-x2)^3/(6*h(i))*sigma(i)+(x2-x(i))^3/(6*h(i))*sigma(i+1) + alpha(i)*(x2-x(i)) + beta(i)*(x(i+1)-x2);
    end

splineFun = @(x2) s(x2);
end
