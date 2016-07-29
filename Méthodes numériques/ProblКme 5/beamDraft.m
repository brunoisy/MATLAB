

function [X,U] = beamDraft()

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
dudx = u;

dudx(1) = u(2);
dudx(2) = cos(x);
end
