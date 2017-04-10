load('RSSI-measurements')
load('stations')
rng(3)

N = 50; % #particles
m = 5;

X = drawInitPart(N);
w = weighPart(X, Y(:,1));

tau1 = zeros(1,m);
tau2 = zeros(1,m);
for n=2:m+1
    X = updatePart(X);
    w = w.*p(X, Y(:,n));
    
    tau1(n) = sum(X(1,:).*w)/sum(w);
    tau2(n) = sum(X(4,:).*w)/sum(w);
end
