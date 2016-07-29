function [ A,b ] = system_construction(f,n)
    h=1/(n+1);
    b=zeros(n*n,1);
    for i= 1:n
        for j= 1:n
           b((i-1)*n+j)= f(i*h,j*h);
        end
    end
    b = (h*h)*b;
    v = zeros(n*n,1);
    for i= 1:n*n
        v(i)= -4;
    end
    D = diag(v);
    L = sparse(n*n,n*n);
    for i= 1:n*n-1 
            if(mod(i,n) ~= 0)
                L(i+1,i)=1;
            end
            if(i<=n*n-n)
                L(i+n,i)=1;
            end
    end
    U = L';
    A = U+L+D;
    
end