%Auteur:William Chermanne ( éclairé et aidé par Ange Ishimwe )
%Date:22/12/2014
%CONVECTION calculates the heat diffusion of a heat source
% This MATLAB function calculates a heat diffusion problem with a finite
% differences method
function [X,Y,U]= convectionWill(n,zeta)

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

for i=(0.75*(n-2)^2)+1:(n-2)^2  % Pour que B soit non nul dans le quart droit
   B(i)=10; 
end

U = zeros(n,n);
U(2:n-1,2:n-1) = reshape(A(map,map)\B,n-2,n-2);

end


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




