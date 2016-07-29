function [x y z] = egg2(top,bottom,dt,mode)

%
% Nous n'utilisons pas la plupart des arguments !
% Seul dt est utilisé :-)
% Ce qui est evidemment incorrect !
%

T = [0 0 0 1 2 3 4];
S = [0 0 0 1 1 2 2 3 3 4];
R = [0 5 2 10];
H = [0 0 10 25];

p = 2;
a = sqrt(3);
Xc = [1 0 1/2 1 3/2 2 1] ;
Yc = [0 0 a/2 a a/2 0 0] ;
Xc = Xc - mean(Xc);
Yc = Yc - mean(Yc);
Zc = ones(size(Xc));
Wc = [1 0.5 1 0.5 1 0.5 1];
X = Xc' * R;
Y = Yc' * R;
Z = Zc' * H;
W = Wc' * [1 1 1 1];

nt = length(T) - 1;
t = [T(p+1):dt:T(n-p+1)];
for i=0:nt-p-1
  Bt(i+1,:) = b(t,T,i,p);
end

ns = length(S) - 1;
s = [S(p+1):dt:S(m-p+1)];
for i=0:ns-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W * Bt;
x = Bs' * (W .* X) * Bt ./ w;
y = Bs' * (W .* Y) * Bt ./ w;
z = Bs' * (W .* Z) * Bt ./ w;


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




