function [Y] = applyToColumns(f, X)
%	applytoColumns 
% it does Y = f(X)
%
% INPUT :
%	- f : function
%	- X : matrix
%
% OUTPUT :
%	- Y : Y=f(X)

Y = zeros(1,size(X,2));
for i = 1:size(X,2)
    Y(i) = f(X(:,i));
end


end