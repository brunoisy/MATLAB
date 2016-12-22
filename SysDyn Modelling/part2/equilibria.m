function [ x_2, x_3, eqtypes ] = equilibria(k1, k2, k3, u, v, C, D)

E = D - C;

jacF = @(x2,x3) [ -k2*x3 - (4*k1*x2*(2*E - 3*x2 + 2*x3))./(E - 3*x2 + x3)^2, (4*k1*x2^2)/(E - 3*x2 + x3)^2 - k2*x2;
                 -k2*x3,               - k2*x2 - 4*k3*(C - x3)];


a0 = 4*k1*(2*k3*C^2 + u)^2 ;
a1 = -(2*k3*C^2 + u)*(6*k2*k3*C^2 + 32*k1*k3*C + 3*k2*u - 3*k2*v);
a2 =  96*C^2*k1*k3^2 + 48*C^3*k2*k3^2 + 16*k1*k3*u + E*k2^2*u - E*k2^2*v+ 2*C^2*E*k2^2*k3 + 24*C*k2*k3*u - 12*C*k2*k3*v;
a3 = -(k2^2*v - k2^2*u + 72*C^2*k2*k3^2 - 2*C^2*k2^2*k3 + 12*k2*k3*u - 6*k2*k3*v + 64*C*k1*k3^2 + 4*C*E*k2^2*k3);
a4 = 2*k3*(8*k1*k3 - 2*C*k2^2 + E*k2^2 + 24*C*k2*k3);
a5 = 2*k2*k3*(k2 - 6*k3);

poly = [a5, a4, a3, a2, a1, a0];


x_3 = roots(poly);
x_3 = x_3(imag(x_3)==0); % we only take real roots
x_2 = (2*k3*(C-x_3).^2+u)./(k2*x_3);
x_2new = x_2((x_2.*x_3>=0) & ((x_2+x_3)>=0)); % we only take positive equilibrias
x_3new = x_3((x_2.*x_3>=0) & ((x_2+x_3)>=0));
x_3 = x_3new;
x_2 = x_2new;



eqtypes = zeros(length(x_2),1);

for i = 1:length(x_2)
    A = jacF(x_2(i),x_3(i));
    lambda  = eig(A);
    eqtypes(i) = eqtype(lambda(1), lambda(2));
end

end