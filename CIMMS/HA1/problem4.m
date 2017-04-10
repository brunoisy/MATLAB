load('RSSI-measurements')
load('stations')
rng(3)

N = 10000; % #particles
m = 100;

X = drawInitPart(N);

w = p(X, Y(:,1));

tau1 = zeros(1,m);
tau2 = zeros(1,m);

tau1(1) = sum(X(1,:).*w)/sum(w);
tau2(1) = sum(X(4,:).*w)/sum(w);

for n=1:m-1    
    %updating
    X = updatePart(X);
    w = p(X, Y(:,n+1));
    
    %estimation
    tau1(n+1) = sum(X(1,:).*w)/sum(w);
    tau2(n+1) = sum(X(4,:).*w)/sum(w);
    
    %resampling
    inds = randsample(N,N,true,w);
    X = X(:,inds);
end

% Plotting
figure
hold on
plot(tau1,tau2,'g*') % estimated trajectory
plot(pos_vec(1,:),pos_vec(2,:), 'o') % stations
xlabel('x1');
ylabel('x2');
legend('estimated trajectory', 'stations')

  