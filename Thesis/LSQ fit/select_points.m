function [Xfirst, Xunfold] = select_points(X, F, x0, Lc, threshlo, threshhi)
% thresh is the max difference between F and the value of the multiFD
% function under which the first and last points of the selected points are
% accepted

margin = 2; %put as args
thresh = 10;

Xfirst = zeros(1, length(Lc));
Xunfold = zeros(1, length(Lc));

for i = 1:length(Lc)
    if(i==1)
        admissX = X(x0<X & X<x0+Lc(i));
        admissF = F(x0<X & X<x0+Lc(i));
    else
        admissX = X(Xunfold(i-1)<X & X<x0+Lc(i));
        admissF = F(Xunfold(i-1)<X & X<x0+Lc(i));
    end
    admissX = admissX(-threshlo < (admissF-fd(Lc(i), admissX-x0)) & (admissF-thresh<fd(Lc(i)+margin, admissX-x0)));
    %admissX(-threshlo < (admissF-fd(Lc(i), admissX-x0)) & (admissF-fd(Lc(i), admissX-x0)<threshhi));%admissX(abs(admissF-fd(Lc(i), admissX-x0))<thresh);
    if ~isempty(admissX)
        Xfirst(i) = admissX(1);
        Xunfold(i) = admissX(end);
    else
        if i==1
            Xfirst(i)=0;
            Xunfold(i)=0;
        else
            Xfirst(i) = Xunfold(i-1);
            Xunfold(i) = Xunfold(i-1);
        end
    end
end
end

