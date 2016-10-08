function X = EulerSymplectique(x0, n, h, w)

m = length(x0);
X = zeros(m, n+1);
X(:,1) = x0;
for i=1:n
    X(1,i+1) = X(1,i) +     h*X(2,i);
    X(2,i+1) = X(2,i) - h*w^2*X(1,i+1);
end

end

