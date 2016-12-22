syms E x2 x3 k1 k2 v k3 u C


y1 = -4*k1*x2^2 / (E+x3-3*x2) - k2*x2*x3 + v;
y2 = -k2*x2*x3+2*k3*(C-x3)^2+u;

J = jacobian( [y1,y2],[x2,x3])
simplify(J,1000)