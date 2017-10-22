function [Xselect, Fselect] = select_points(X, F, x0, Lc, thresh)
%SELECT_POINTS Summary of this function goes here
%   Detailed explanation goes here

X = X-x0;
for i = 1:length(Lc)
    if(i==1)
        Xinterval = X(0<X & X<Lc(i));
        Finterval = F(0<X & X<Lc(i));
        Xselect   = Xinterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh);
        Fselect   = Finterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh);
    else
        Xinterval = X(Xselect(end)<X & X<Lc(i));
        Finterval = F(Xselect(end)<X & X<Lc(i));
        Xselect   = [Xselect, Xinterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh)];
        Fselect   = [Fselect, Finterval(abs(fd(Lc(i),Xinterval)-Finterval)<thresh)];
    end
end
Xselect = Xselect+x0;
end

