function [x y z] = oldegg(top,bottom,dt,mode)

%
% Nous n'utilisons pas la plupart des arguments !
% Seul dt est utilisé :-)
% Ce qui est evidemment incorrect !
%

T = [0 0 0 1 1 2 2 3];
S = [0 0 0 1 1 2 2 3 3 4 4 5];

p = 2;
Xc = [1 2 3 4 5 6 7 8 9];
Yc = [1 2 3 4 5 6 7 8 9];
Zc = ones(size(Xc));
Wc = [1 2 3 4 5 6 7 8 9];
X = Xc';
Y = Yc';
W = Wc';


ns = length(S) - 1;
s = [S(p+1):dt:S(ns-p+1)];
for i=0:ns-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W;
x = Bs' * (W .* X) ./ w;
y = Bs' * (W .* Y) ./ w;

plot(Xc, Yc, 'r*'); hold on
plot(x, y, 'g*-')

end


function u = b(t,T,j,p)
i = j+1;
if p==0
    u = (t>= T(i) & t < T(i+p+1)); return 
end

u = zeros(size(t));
if T(i) ~= T(i+p)
    u = u + ((t-T(i)) / (T(i+p) -T(i))) .* b(t,T,j,p-1);
end
if T(i+1) ~= T(i+p+1)
    u = u + ((T(i+p+1)-t) ./ (T(i+p+1) -T(i+1))) .* b(t,T,j+1,p-1);
end
end




