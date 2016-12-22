function [T, x_2, x_3] = ozone(k_1, k_2, k_3, u, v, x0_1, x0_2, x0_3, x0_4, dt, tend)

    function dx = f(t,x)
        x2 = x(1);
        x3 = x(2);
        x1 = x0_1-3/2*(x2-x0_2) + 1/2*(x3-x0_3); 
        x4 = x0_4-(x3-x0_3);
        
        C = [-2,-1,0;0,-1,2];
        r = [k_1*x2^2/x1; k_2*x2*x3; k_3*x4^2];
   
        dx = C*r + [v; u];
    end

x0 = [ x0_2; x0_3];
tspan = [0:dt:tend];
[T,X] = ode45(@f,tspan,x0);

x_2 = X(:,1);
x_3 = X(:,2);

end

