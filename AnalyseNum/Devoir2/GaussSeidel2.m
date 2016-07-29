function [A b x G] = GaussSeidel2(f, n, err)
    h=1/(n+1);
 
    b=zeros((n+2)^2,1);
    b(1:n+2) = 0:h:1; % Contrainte u(x,0)=x
    b(((n+2)^2-(n+1)):(n+2)^2) = ones(1,n+2)-(0:h:1);% Contrainte u(x,1)=1-x
    b(1:n+2:((n+2)^2-(n+1)),1) = 0:h:1;% Contrainte u(0,y)=y
    b(n+2:n+2:(n+2)^2,1) = ones(1,n+2)-(0:h:1);% Contrainte u(1,y)=1-y
    
    for i= 1:n
        for j= 1:n
           b(i*(n+2)+(j+1))= -(h^2)*f(i*h,j*h);
        end
    end
    %b est maintenant completée
    
    A=sparse((n+2)^2, (n+2)^2);
   
    
    for i=1:n+2
        A(i,i)=1; % pour appliquer la contrainte u(x,0)=x
        A((n+2)^2-(n+2)+i,(n+2)^2-(n+2)+i)=1; % pour appliquer la contrainte u(x,1)=1-x
        A(i*(n+2),i*(n+2))=1; % pour appliquer la contrainte u(0,y)=y
        A((i-1)*(n+2)+1,(i-1)*(n+2)+1)=1; % pour appliquer la contrainte u(1,y)=1-y
    end
    
    for i=(n+3):((n+2)^2-(n+3))
        if(mod(i,n+2) ~= 0 && mod(i-1,n+2) ~= 0 ) %% si le noeud considéré n'est pas sur les limites
           A(i, i-3)=-1;
           A(i, i-1)=-1;
           A(i, i)= 4;
           A(i, i+1)=-1;
           A(i, i+3)=-1;
        end        
    end
    %A est maintenant completée
    
    L=tril(A, -1);
    D=diag(diag(A));
    U=triu(A, 1); 
    
    G = (D+L)'-U;
    
    % D, L, U, b sont initialises, on peut alors commencer Gauss-Seidel
    itere = zeros((n+2)^2,1);
    x = (D+L)\(-U*itere+b);
    while(norm(itere-x) > err)
       itere = x;
       x = (D+L)\(-U*x+b);
    end 
end