function lecture4()

T = [0 0 0 1 2 3 4];
S = [0 0 0 1 1 2 2 3 3 3];
R = [0 5 2 10];
H = [0 0 10 25];
% superpotje(T,S,R,H);
simplepotje(T,S,R,H);
 
end

function simplepotje(T,S,R,H)
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

set(figure,'Unit','normal','Color',[1 1 1],...
    'Name','NURBS','Number','off');
axis off; axis equal;
potje(X,Y,Z,W,S,T,2); 
end

function superpotje(T,S,R,H)
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

set(figure,'Unit','normal','Color',[1 1 1],...
    'Name','NURBS','Number','off');
plot3(X(:,1),Y(:,1),Z(:,1),'.y','MarkerSize',20); hold on;  
plot3(X(:,2),Y(:,2),Z(:,2),'.r','MarkerSize',20); 
plot3(X(:,3),Y(:,3),Z(:,3),'.m','MarkerSize',20); 
plot3(X(:,4),Y(:,4),Z(:,4),'.b','MarkerSize',20); 
axis off; axis equal;
potje(X,Y,Z,W,S,T,2); 
end

function potje(X,Y,Z,W,S,T,p)

nt = length(T) - 1;x
t = [T(p+1):0.05:T(nt-p+1)];
for i=0:nt-p-1
  Bt(i+1,:) = b(t,T,i,p);
end

ns = length(S) - 1;
s = [S(p+1):0.05:S(ns-p+1)];
for i=0:ns-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W * Bt; % dén
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