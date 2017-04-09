load('RSSI-measurements')
load('stations')
rng(3)

N = 50; % #particles
m = 100;

X = drawInitPart(N);
w = weighPart(X);

tau1 = zeros(1,m);
tau2 = zeros(2,m);
for n=1:m
    X = updatePart(X);
    w = weighPart(X);
    
    tau1(n) = sum(X(1,:).*w)/sum(w);
    tau2(n) = sum(X(4,:).*w)/sum(w);
end
