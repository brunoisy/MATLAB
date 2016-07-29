function beautifulConvection()

n = 82;
h =  2.0/(n-1);
X = -1.0:h:1.0;
Y = -1.0:h:1.0;


A = sparse(n^2,n^2);
map = zeros((n-2)^2,1);
for i = 2:n-1
    for j = 2:n-1
        index = (i-1)*n + j;
        map((i-2)*(n-2)+j-1) = index;
        A(index,index)   = -4;
        A(index,index+1) =  1;
        A(index,index-1) =  1;
        A(index,index+n) =  1;
        A(index,index-n) =  1;
    end
end

A = A/(h^2);
B = -ones((n-2)^2,1);

U = zeros(n,n);
U(2:n-1,2:n-1) = reshape(A(map,map)\B,n-2,n-2);
contourf(X,Y,U); 
axis off; axis equal
end





