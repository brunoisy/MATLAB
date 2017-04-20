load('RSSI-measurements')
load('stations')
rng(3)

N = 1000; % #particles
m = length(Y(1,:));

X = drawInitPart(N);
w = p(X, Y(:,1));

allWeights = zeros(m,N);
allWeights(1,:) = w;

tau1 = zeros(1,m);
tau2 = zeros(1,m);
tau1(1) = sum(X(1,:).*w)/sum(w);
tau2(1) = sum(X(4,:).*w)/sum(w);


for n=2:m
    X = updatePart(X);
    w = w.*p(X, Y(:,n));
    
    tau1(n) = sum(X(1,:).*w)/sum(w);
    tau2(n) = sum(X(4,:).*w)/sum(w);
    
    allWeights(n,:) = w;
end

% Plotting
figure
hold on
plot(tau1,tau2,'g*') % estimated trajectory
plot(pos_vec(1,:),pos_vec(2,:), 'o') % stations
xlabel('x1');
ylabel('x2');
legend('estimated trajectory', 'stations')


% histogram of importance weights
figure
histogram(log10(allWeights(1,:)))

figure
histogram(log10(allWeights(10,:)))

figure
histogram(log10(allWeights(100,:)))

% efficient sample size?