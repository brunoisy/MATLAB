function [Xsel, Fsel, Xfirst, Xunfold] = select_points(X, F, x0, Lc, thresh)
% thresh is the max difference between F and the value of the multiFD
% function under which the first and last points of the selected points are
% accepted


Xfirst = zeros(1, length(Lc));
Xunfold = zeros(1, length(Lc));
Xsel = [];
Fsel = [];
for i = 1:length(Lc)
    if(i==1)
        admissX = X(x0<X & X<x0+Lc(i));
        admissF = F(x0<X & X<x0+Lc(i));
    else
        admissX = X(Xunfold(i-1)<X & X<x0+Lc(i));
        admissF = F(Xunfold(i-1)<X & X<x0+Lc(i));
    end
    admissX = admissX(abs(admissF-fd(Lc(i), admissX-x0))<thresh);
    if ~isempty(admissX)
        Xfirst(i) = admissX(1);
        Xunfold(i) = admissX(end);
        Xsel = [Xsel, X(Xfirst(i)<=X & X<Xunfold(i))];
        Fsel = [Fsel, F(Xfirst(i)<=X & X<Xunfold(i))];
    end
end
end

