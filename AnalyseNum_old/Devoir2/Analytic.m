function [ U ] = Analytic(f, n)
    h=1/(n+1);
    B=zeros(n,n);
    for i= 1:n
        for j= 1:n
            B(i,j)= f(i*h,j*h);
        end
    end
    V = zeros(n,n);
    lambda = zeros(n,1);
    for i= 1:n
        lambda(i) = -4*sin(i*pi/(2*n+2))^2;
        for j= 1:n
            V(i,j)= sin(i*j*pi/(n+1));
        end
    end
    Q = 4*h^2/(n+1)^2*V*B*V;
    C = zeros(n,n);
    for i= 1:n
        for j=1:n
            C(i,j)=Q(i,j)/(lambda(i)+lambda(j));
        end
    end
    U = V*C*V;
end