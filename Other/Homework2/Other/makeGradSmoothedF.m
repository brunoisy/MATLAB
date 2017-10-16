function [gradF] = makeGradSmoothedF(A, b, mu, lambda)
%	makeGradSmoothedF
% It obtain a gradient smooth for l1-LS problem
%
% min{f(x) = ||Ax-b||^2 + lambda ||x||_1}
%
% INPUT :
%	- A : matrix A from the problem
%	- b : matrix b from the problem
% 	- lambda : parameter lambda from the problem
%	- mu : parameter
%
% OUTPUT
%	- gradF : Gradient with smoothing

    function y = gradH(x)
        if abs(x) <= mu 
            y=x/mu;
        else
            y=sign(x);
        end
    end

    function gradFofX = newGradF(x)
        n = length(x);
        gradHn = zeros(n,1);
        for i=1:n
            gradHn(i) = gradH(x(i));
        end

        gradFofX = 2*A'*(A*x-b)+lambda*gradHn;
    end
gradF = @newGradF;
end