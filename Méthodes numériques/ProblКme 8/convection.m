function [X, Y, U]=convection(n,zeta)
% convection - this MATLAB function finds the value of U on each node
% (X,Y), by solving a convection problem. It takes as argument n, the
% number wich squared gives the number of nodes to evaluate, and zeta, wich
% is equivalent to rho*C, the volumic mass times the specific heat of the
% material.

% Bruno Degomme
% 3972 13 00

h =  2.0/(n-1);
X = -1.0:h:1.0;
Y = -1.0:h:1.0;

A = sparse(n^2,n^2);
map = zeros((n-2)^2,1);
for i = 2:n-1
    for j = 2:n-1
        index = (i-1)*n + j;
        map((i-2)*(n-2)+j-1) = index;
        [u,v] = velocity(X(i),Y(j));
        A(index,index)   = 4;
        A(index,index+1) =  1*zeta*(h/2)*v-1;
        A(index,index-1) =  -1*zeta*(h/2)*v-1;
        A(index,index+n) =  1*zeta*(h/2)*u-1;
        A(index,index-n) =  -1*zeta*(h/2)*u-1;
    end
end

A = (A/(h^2));
B = zeros((n-2)^2,1);

for i=(0.75*(n-2)^2)+1:(n-2)^2
   B(i)=10; % met à 10 le quart droit de domaine
end

U = zeros(n,n);
U(2:n-1,2:n-1) = reshape(A(map,map)\B,n-2,n-2);

function [u,v] = velocity(x,y)

epsilon = 1/5;
zp = (-1+ sqrt(1+4*(pi*epsilon)^2))/(2*epsilon);
zm = (-1- sqrt(1+4*(pi*epsilon)^2))/(2*epsilon);
D = ((exp(zm)-1)*zp + (1-exp(zp))*zm)/(exp(zp)-exp(zm));
fu = (pi/D) * (1+ ((exp(zm)-1)*exp(zp*(x+1)/2) + (1-exp(zp))*exp(zm*(x+1)/2))/(exp(zp)-exp(zm)));
fv = (1/D) * (((exp(zm)-1)*zp*exp(zp*(x+1)/2) + (1-exp(zp))*zm*exp(zm*(x+1)/2))/(exp(zp)-exp(zm)));
u = fu.*sin(pi*y/2);
v = fv.*cos(pi*y/2);

end
end





