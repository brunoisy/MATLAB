function dy = f1(y)
    m1 = 1;
    m2 = 1;
    l1 = 0.3;
    l2 = 0.5;
    g = 9.81;
    dy = zeros(2,1);
    
    den = 2*m2*l1^2*l2^2*(m1+m2*(sin(y(1)-y(2)))^2);
    a = 2*m2*l1*l2*y(3)*y(4)*cos(y(1)-y(2));
    b = 2*m2*l1*l2*y(3)*y(4)*sin(y(1)-y(2));
    c = 4*m2^2*l1^2*l2^2*sin(y(1)-y(2))*cos(y(1)-y(2));
    
    dy(1) = (2*m2*l2^2*y(3)-2*m2*l1*l2*y(4)*cos(y(1)-y(2)))/den;% theta1'
    dy(2) = (2*(m1+m2)*l1^2*y(4)-2*m2*l1*l2*y(3)*cos(y(1)-y(2)))/den;% theta2'
end