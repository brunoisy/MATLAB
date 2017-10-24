function [Xsel, Fsel, Xfirst, Xlast] = select_points(X, F, x0, Lc, thresh, xmin)
%SELECT_POINTS Summary of this function goes here
%   Detailed explanation goes here


Fx = multi_fd([x0, Lc], X, Lc);%theoretical value of the force at points X according to x0,Lc

Xlast = zeros(1, length(Lc));
Xfirst = zeros(1, length(Lc));

for i = 1:length(Lc)
    if(i==1)
        admissX = X(x0+xmin<X & X<Lc(i) & abs(F-Fx)<thresh);
        Xfirst(i) = admissX(1);
        Xlast(i) = admissX(end);
        Xsel = X(Xfirst(i)<=X & X<Xlast(i));
        Fsel = F(Xfirst(i)<=X & X<Xlast(i));
    else
        admissX = X(Xlast(i-1)<X & X<Lc(i) & abs(F-Fx)<thresh);
        Xfirst(i) = admissX(1);
        Xlast(i) = admissX(end);
        Xsel = [Xsel, X(Xfirst(i)<=X & X<Xlast(i))];
        Fsel = [Fsel, F(Xfirst(i)<=X & X<Xlast(i))];
    end
    i
end


% X = X-x0;
% for i = 1:length(Lc)
%     if(i==1)
%         Xinterval = X(xmin<X & X<Lc(i));
%         Finterval = F(xmin<X & X<Lc(i));
%         Xselect   = Xinterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh);
%         Fselect   = Finterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh);
%
%     else
%         Xinterval = X(Xcut(i-1)<X & X<Lc(i));
%         Finterval = F(Xcut(i-1)<X & X<Lc(i));
%         Xselect   = [Xselect, Xinterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh)];
%         Fselect   = [Fselect, Finterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh)];
%     end
%     if ~isempty(Xselect)
%         Xcut(i) = Xselect(end);
%     end
% end
% Xcut = Xlast+x0;
% Xselect = Xselect+x0;
end

