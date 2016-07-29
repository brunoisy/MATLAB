rng(10);% pour obtenir toujours le même résultat
N = 1000;
n = [10 20 40 80 160 320 640 1280];

eta = 1;
beta = eta/sqrt(log(2));
gamma = 2;

I = norminv([0.025 0.975],0,1);
z = I(2); % (z = 1.96, comme dans tables)


f = makedist('Weibull', 'a', beta, 'b', gamma);
C = sqrt(log(2));
lnEta = log(beta*C);

L2 = zeros(1,N);
U2 = zeros(1,N);
RejH = zeros(1,N);

a = length(n);
meanRejH = zeros(1,a);

for j = 1:a % pour n taille de samples
    K = sqrt((4-pi)/(4*n(j)));
    for i = 1:N % pour N samples
        X = random(f, [1, n(j)]);
        meanX = mean(X);
        
        L2(i) = log(meanX*C/(sqrt(pi)/2 + K*z));
        U2(i) = log(meanX*C/(sqrt(pi)/2 - K*z));
        
        if(lnEta < L2(i) || U2(i) < lnEta)
            RejH(i) = 1;
        end
    end
    meanRejH(j) = mean(RejH);
    RejH = zeros(1,N);
end
