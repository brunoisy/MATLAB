rng(10);% pour obtenir toujours le même résultat
N = 1000;
n = [10 20 40 80 160 320 640 1280];

beta = 2;
gamma = 2;
I = norminv([0.025 0.975],0,1);
z = I(2); % (z = 1.96, équivalent à tables)

f = makedist('Weibull', 'a', beta, 'b', gamma);
C = sqrt(log(2));
lnEta = log(beta*C);

L1 = zeros(1,N);
U1 = zeros(1,N);
Z1 = zeros(1,N);
W1 = zeros(1,N);

a = 8;
meanZ1 = zeros(1,a); 
meanW1 = zeros(1,a);

for j = 1:a
    K = sqrt((4-pi)/(4*n(j)));
    for i = 1:N
        X = random(f, [1, n(j)]);
        meanX = mean(X);
        L1(i) = log(meanX*C/(sqrt(pi)/2 + K*z));
        U1(i) = log(meanX*C/(sqrt(pi)/2 - K*z));

        if(lnEta > L1(i) && lnEta < U1(i))
            Z1(i) = 1;
        end
        W1(i) = U1(i) - L1(i);
    end
    meanZ1(j) = mean(Z1); % doit être à peu pres 95%
    %var(Z1)
    meanW1(j) = mean(W1);
    %var(W1)    
    Z1 = zeros(1,N);
end

plot(n, meanZ1);
figure
plot(n, meanW1);
