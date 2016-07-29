function [x, y, z] = egg(top,bottom,dt,mode)
% Auteur : Bruno Degomme
% date : le 20/10/14


% soient les noeuds suivants
T = [0, 0, 0, 1, 1, 2, 2, 3];
S = [0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5];

R = [0 1 1 1 0]; % le rayon de l'oeuf est nul aux extrémités, et existant aux autes points 
c = sqrt(.75);
H = [-1*bottom -c*bottom 0 c*top 1*top]; 
% 'hauteur' de l'oeuf en fonction de top et bottom, hauteur à laquelle se trouveront les 5 plans de 9 points de controles (hauteurs de Z)

% Comme les surfaces par lesquelles nous approximons notre sphère sont de
% degré 2, p=q=2
p=2;
n=length(T)-1;
m=length(S)-1;

% Xc, Yc les coordonées des P
Xc=[-1 -1 0 1 1 1 0 -1 -1];
Yc=[0 1 1 1 0 -1 -1 -1 0];
Zc=ones(size(Xc)); 

a=sqrt(2)/2;
Wc=[1 a 1 a 1 a 1 a 1];
X = Xc' * R;
Y = Yc' * R;
Z = Zc' * H;
W = Wc' * [1 a 1 a 1];


t = [T(p+1):dt:T(n-p+1)];
for i=0:n-p-1
  Bt(i+1,:) = b(t,T,i,p);
end

s = [S(p+1):dt:S(m-p+1)];
for i=0:m-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W * Bt;
x = Bs' * (W .* X) * Bt ./ w;
y = Bs' * (W .* Y) * Bt ./ w;
z = Bs' * (W .* Z) * Bt ./ w;

surf(x,y,z);
axis('off');
axis('equal');

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




