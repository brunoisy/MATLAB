function X = EulerExplicite(F, x0, n, h)

m = length(x0);
X = zeros(m, n+1);
X(:,1) = x0;
for i=1:n
    X(:,i+1) = X(:,i) + h*F(X(:,i));
end

end

