function [X,U] = beam()
% beam - Solve nonstiff differential equations using 4th order Runge-Kutta
% method
%
%    This MATLAB function uses the 4th order Runge-Kutta method to integrate 
%    the system of differential equations y = f(t,y) from time Xstart (0) to 
%    Xend (15) with initial conditions Ustart(0 0)
%
%    [X, U] = beam()
%
%    See also function_handle, integral, integral2, integral3, quad, quad2d

% BRUNO DEGOMME
% 22/11/14

Xstart = 0;
Xend   = 15;
Ustart = [0 0];

n = 1000;
h = (Xend-Xstart)/n;
X = linspace(Xstart,Xend,n+1);
U = [Ustart ; zeros(n,2)];

for i=1:n
    K1 = f(X(i),     U(i,:)        );
    K2 = f(X(i)+h/2, U(i,:)+h*K1/2 );
    K3 = f(X(i)+h/2, U(i,:)+h*K2/2 );
    K4 = f(X(i)+h,   U(i,:)+h*K3   );
    U(i+1,:) = U(i,:) + h*(K1+2*K2+2*K3+K4)/6;
end

end



function dudx = f(x,u)
% dudx - Create functions of amplitude and variation of amplitude in
% function of time
%
%   This MATLAB function uses a second order differential equation to find
%   the first and second order derivatives of amplitude. x, u(1) and u(2)
%   are respectively the time, amplitude and first derivative of amplitude
%   at wich those solutions are wanted.
%
%   [U1, U2] = f(x,u)

dudx = u;
dudx(1) = u(2);

L = 1;
k = 140;
m = 10;
g = 9.81;
C = 10;

depl = sqrt(3-2.828427*L^2*cos(u(1)+pi/4))-11/10*L; % etirement du ressort par rapport à son point d'equilibre
Mressort = -L*cos(u(1)-(pi/4 - asin(sin(pi/4 +u(1))/(depl+11/10*L))))*k*depl; % moment de force du ressort
Mpoids = L*m*g*sin(u(1)); % moment de force du au poids de la barre

dudx(2)=3/(4*m)*(Mressort + Mpoids - C*u(2));
end
