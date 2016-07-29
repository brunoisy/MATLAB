function test_matlab3BRU()

n = 9; 
X = linspace(0,1,n+1);
U = exp(-2*X).*sin(10*pi*X)+10*X;
dU = 10*pi*exp(-2*X).*cos(10*pi*X) -2 *U+10;

x = linspace(-0.1,1.1,100);
u = exp(-2*x).*sin(10*pi*x)+10*x;
uh = hermite(n,X,U,dU,x);

close all;
plot(x,u,'b-', x, uh, 'r-', X,U,'b.','Markersize',25);
fprintf('==== uh(18) %14.7e \n',uh(18));
 
end