function [jacobF] = jacF(h)

m1 = 1;
m2 = 1;
l1 = 0.3;
l2 = 0.5;
g = 9.81;
syms y1 y2 y3 y4;

den(y1, y2, y3, y4) = 2*m2*l1^2*l2^2*(m1+m2*(sin(y1-y2))^2);
a(y1, y2, y3, y4) = 2*m2*l1*l2*y3*y4*cos(y1-y2);
b(y1, y2, y3, y4) = 2*m2*l1*l2*y3*y4*sin(y1-y2);
c(y1, y2, y3, y4) = 4*m2^2*l1^2*l2^2*sin(y1-y2)*cos(y1-y2);

f1(y1, y2, y3, y4) = (2*m2*l2^2*y3-2*m2*l1*l2*y4*cos(y1-y2))/den;% theta1'
f2(y1, y2, y3, y4) = (2*(m1+m2)*l1^2*y4-2*m2*l1*l2*y3*cos(y1-y2))/den;% theta2'
f3(y1, y2, y3, y4) = -((m1+m2)*g*l1*sin(y1)+(b/den)-(m2*l2^2*y3^2+(m1+m2)*l1^2*y4^2-a)*c/den^2);% ptheta1'
f4(y1, y2, y3, y4) = -(m2*g*l2*sin(y2)-(b/den)+(m2*l2^2*y3^2+(m1+m2)*l1^2*y4^2-a)*c/den^2);% ptheta2'

F(y1, y2, y3, y4) = [y1; y2; y3; y4] - h*[f1; f2; f3; f4]; % en réalité, - y_{i-1}, mais ne joue pas dans la jacobienne
jacobF(y1, y2, y3, y4) = jacobian(F, [y1, y2, y3, y4]);
end