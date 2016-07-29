
f = @(x,y)(4*cos(x^2+y^2)-4*sin(x^2+y^2)*(x^2+y^2));
n=3;
h=1/(n+1);

for i=1:n
    for j=1:n
        fval(i,j)=f(i*h,j*h);
        fval2(i,j)=-(h^2)*f(i*h,j*h);
    end
end
