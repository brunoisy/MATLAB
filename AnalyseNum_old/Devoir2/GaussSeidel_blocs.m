function [x] = GaussSeidel_blocs(n,err,A,b)

%%%%%%%%%%%%%%
% cas n pair %
%%%%%%%%%%%%%%
if(mod(n,2)==0)
    %A11 = eye((n^2)/2);
    A12 = A(1:n^2/2,(n^2)/2+1:n^2);
    A21 =A12';
    %A22 = A11;
    
    b1 = b(1:n^2/2);
    b2 = b((n^2/2)+1:n^2);
    
    x1 = zeros(n^2/2,1);
    x2 = zeros(n^2/2,1);
    
    itere1 = x1;
    itere2 = x2;
    
    x1 = -0.25*(b1-A12*x2);
    x2 = -0.25*(b2-A21*x1);
    
    x = [x1;x2];
    itere = [itere1;itere2];
    while(norm(itere-x)>err)
        itere1 = x1;
        itere2 = x2;
        x1 = -0.25*(b1-A12*x2);
        x2 = -0.25*(b2-A21*x1);
        x = [x1;x2];
        itere = [itere1;itere2];
    end
%%%%%%%%%%%%%%%%
% cas n impair %
%%%%%%%%%%%%%%%%    
    
else
    black = floor(n^2/2);
    red =  n^2-black;
    
    %A11 = eye(black);
    A12 = A(1:black,black+1:n^2);
    A21 = A12';
    %A22 = eye(red);
    
    bb = b(1:black);
    br = b(black+1:n^2);
    
    xb = zeros(black,1);
    xr = zeros(red,1);
    
    itereb = xb;
    iterer = xr;
    
    xb = -0.25*(bb-A12*xr);
    xr = -0.25*(br-A21*xb);
    x = [xb;xr];
    itere = [itereb;iterer];
    i = 1;
    while(norm(itere-x)>err)
        e(i) = norm(itere-x);
        i=i+1;
        itereb = xb;
        iterer = xr;
        xb = -0.25*(bb-A12*xr);
        xr = -0.25*(br-A21*xb);
        x = [xb;xr];
        itere = [itereb;iterer];
    end
    
end

end