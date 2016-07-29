A = [0, 1; -2, -3];
B = [0; 1];
C = [1, -1];
D = 0;

syms t s
u = exp(t);
U = laplace(u);
y = ilaplace(C*inv(s*eye(2)-A)*B*U);
T = 0:9;
Y = zeros(1, 10);
for i = 1:10
    t = T(i);
 
    Y(i) = subs(y);
end

plot(T, Y)