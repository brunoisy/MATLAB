load('Data/RSSI-measurements')
load('Data/stations')
rng(3)

N = 10000; % #particles
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
% Trajectory
figure
hold on
title('estimated trajectory of the target using SIS','FontSize',14)
plot(tau1,tau2,'*') % estimated trajectory
plot(pos_vec(1,:),pos_vec(2,:), 'or','MarkerFaceColor','r') % stations
xlabel('$x_1$','FontSize',16,'Interpreter','latex');
ylabel('$x_2$','FontSize',16,'Interpreter','latex');
lgd = legend('estimated trajectory', 'stations');
lgd.FontSize = 12;

% Importance Weights Histogram
edges = -18:0.1:0;
figure
subplot(4,1,1)
histogram(log10(allWeights(1,:)),edges)
title('n=1')
ylabel('# of particles')

subplot(4,1,2)
histogram(log10(allWeights(5,:)),edges)
title('n=5')

subplot(4,1,3)
histogram(log10(allWeights(10,:)),edges)
title('n=10')

subplot(4,1,4)
histogram(log10(allWeights(15,:)),edges)
title('n=15')
xlabel('Importance Weights (base 10 logarithm)')

% Efficient Sample Size
n = [1 5 10 15 20 25 30 35 40 45 50 75 100 125 150 175 200];
ESS = zeros(1,length(n));
for i=1:length(n)
    normWeights = allWeights(n(i),:)./sum(allWeights(n(i),:));
    ESS(i) = 1/sum(normWeights.^2);
end

