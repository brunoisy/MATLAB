n = 3;
P = zeros(1,n);
K = zeros(1,n);

P(1) = 4;
for k = 1:n-1
    P(k+1) = 0.9^2*P(k)+1-0.9*P(k)^2/(P(k)+4);
end

for k = 1:n
    K(k) = P(k)/(P(k)+4);
end

P
K