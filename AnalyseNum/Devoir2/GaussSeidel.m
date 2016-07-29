function [ x ] = GaussSeidel(f, n, err)
    h=1/(n+1);
    b=zeros(n^2,1);
    for i= 1:n
        for j= 1:n
           b((i-1)*n+j)= f(i*h,j*h);
        end
    end
    b = (h^2)*b;
    
    v = -4 * ones(n^2,1);
    D = diag(v);
    L = sparse(n^2,n^2);
    for i= 1:n*n-1 
            if(mod(i,n) ~= 0)
                L(i+1,i)=1;
            end
            if(i<=n*n-n)
                L(i+n,i)=1;
            end
    end
    U = L';
    % D, L, U, b sont initialises, on peut alors commencer gauss-Seidel:
    %(D+L)xk+1 = -Uxk+b
    x = zeros(n*n,1);
    itere = x;
    x = (D+L)\(-U*itere+b);
    while(norm(itere-x) > err)
       itere = x;
       x = (D+L)\(-U*x+b);
    end
end