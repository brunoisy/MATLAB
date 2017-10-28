function [Xsel, Fsel, Xfirst, Xlast] = select_points(X, F, x0, Lc, thresh, xmin)
% thresh is the max difference between F and the value of the multiFD
% function under which the first and last points of the selected points are
% accepted


Xlast = zeros(1, length(Lc));
Xfirst = zeros(1, length(Lc));
for i = 1:length(Lc)
    if(i==1)
        admissX = X(max(xmin,x0)<X & X<Lc(i));
        admissF = F(max(xmin,x0)<X & X<Lc(i));
        admissX = admissX(abs(admissF-fd(Lc(i), admissX-x0))<thresh);% add if isempty(admissX)... for robustness? (problem when 2 Lc curves collapse)
        Xfirst(i) = admissX(1);
        Xlast(i) = admissX(end);
        Xsel = X(Xfirst(i)<=X & X<Xlast(i));
        Fsel = F(Xfirst(i)<=X & X<Xlast(i));
    else
        admissX = X(Xlast(i-1)<X & X<Lc(i));
        admissF = F(Xlast(i-1)<X & X<Lc(i));
        admissX = admissX(abs(admissF-fd(Lc(i), admissX-x0))<thresh); 
        Xfirst(i) = admissX(1);
        Xlast(i) = admissX(end);
        Xsel = [Xsel, X(Xfirst(i)<=X & X<Xlast(i))];
        Fsel = [Fsel, F(Xfirst(i)<=X & X<Xlast(i))];
    end 
end
end

