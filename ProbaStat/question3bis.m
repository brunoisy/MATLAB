rng(10);% pour obtenir toujours le même résultat
N = 1000;
n = 10;

beta = 2;
gamma = 2;
alpha = 5;
I = tinv([0.025 0.975],n-1);
t = I(2);


f = makedist('Weibull', 'a', beta, 'b', gamma);
C = sqrt(log(2));
lnEta = log(beta*C);
L2 = zeros(1,N);
U2 = zeros(1,N);
Z2 = zeros(1,N);
W2 = zeros(1,N);


for j=1:N
    X = random(f, [1, n]);
    meanX = mean(X);
    sum = 0;
    for i=1:n
        sum = sum + (X(i) -meanX)^2;
    end
    S = sqrt(sum/(n-1));

    L2(j) = log(-(2*C)/sqrt(pi)*(-meanX + S/sqrt(n)*t));
    U2(j) = log(-(2*C)/sqrt(pi)*(-meanX - S/sqrt(n)*t));
    if(lnEta > L2(j) && lnEta < U2(j))
        Z2(j) = 1;
    end
    W2(j) = U2(j) - L2(j);
end
meanZ2 = mean(Z2) % doit être à peu pres 95%
var(Z2)
meanW2 = mean(W2)
var(W2)    