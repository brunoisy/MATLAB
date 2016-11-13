function [s, sigma] = Reinsch(x, y, alpha)


n = length(x)-2;
h = x(2:end) - x(1:end-1);% length = m

Q = sparse(n+2,n);
for i = 2:n+1 % problem indexation des h P6 addenda (i->i-1) A VERIFIER!
    Q(i-1,i-1) = 1/h(i-1);
    Q(i,i-1)   = -1/h(i-1) -1/h(i);
    Q(i+1,i-1) = 1/h(i);
end

R = sparse(n,n);
R(1,1) = 1/3*(h(1)+h(2));
for i=2:n;
    R(i,i)   = 1/3*(h(i)+h(i+1));
    R(i-1,i) = 1/6*h(i);
    R(i,i-1) = 1/6*h(i);
end

    
sigma = (R + alpha*(Q'*Q))\(Q'*y);
s = y - alpha*Q*sigma;
end

