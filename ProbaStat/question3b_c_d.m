rng(10);% pour obtenir toujours le même résultat
N = 1;
n = [10];%[10 20 40 80 160 320 640 1280];

beta = 2;
gamma = 2;

I = norminv([0.025 0.975],0,1);
z = I(2); % (z = 1.96, comme dans tables)


f = makedist('Weibull', 'a', beta, 'b', gamma);
C = sqrt(log(2));
lnEta = log(beta*C);

L1 = zeros(1,N);
U1 = zeros(1,N);
Z1 = zeros(1,N);
W1 = zeros(1,N);
L2 = zeros(1,N);
U2 = zeros(1,N);
Z2 = zeros(1,N);
W2 = zeros(1,N);

a = length(n);
meanZ1 = zeros(1,a); 
meanW1 = zeros(1,a);
meanZ2 = zeros(1,a); 
meanW2 = zeros(1,a);

for j = 1:a % pour n taille de samples
    K = sqrt((4-pi)/(4*n(j)));
    I = tinv([0.025 0.975], n(j)-1);
    t = I(2); %  comme dans tables
    for i = 1:N % pour N samples
        X = random(f, [1, n(j)]);
        meanX = mean(X);
        sum = 0;
        for k = 1:n(j)
            sum = sum + (X(k) - meanX)^2;
        end
        S = sqrt(sum/(n(j)-1));
        
        L1(i) = log(-(2*C)/sqrt(pi)*(-meanX + S/sqrt(n(j))*t));
        U1(i) = log(-(2*C)/sqrt(pi)*(-meanX - S/sqrt(n(j))*t));
        L2(i) = log(meanX*C/(sqrt(pi)/2 + K*z));
        U2(i) = log(meanX*C/(sqrt(pi)/2 - K*z));

        if( L1(i) < lnEta && lnEta < U1(i))
            Z1(i) = 1;
        end
        if( L2(i) < lnEta && lnEta < U2(i))
            Z2(i) = 1;
        end
        W1(i) = U1(i) - L1(i);
        W2(i) = U2(i) - L2(i);
    end
    meanZ1(j) = mean(Z1); % doit être à peu pres 95%
    meanZ2(j) = mean(Z2); % doit être à peu pres 95%
    meanW1(j) = mean(W1);
    meanW2(j) = mean(W2); 
    
    Z1 = zeros(1,N);% (réinitialisation)
    Z2 = zeros(1,N);
end

figure
plot(n, meanZ1);
hold on;
plot(n, meanZ2);
title('mean(Z) in function of n')
xlabel('n')
ylabel('mean(Z)')
legend('mean(Z1)','mean(Z2)')
figure
plot(n, meanW1);
hold on;
plot(n, meanW2);
title('mean(W) in function of n')
xlabel('n')
ylabel('mean(W)')
legend('mean(W1)','mean(W2)')
