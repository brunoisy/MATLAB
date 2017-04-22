load('Data/RSSI-measurements-unknown-sigma')
load('Data/stations')
rng(3)

N = 1000; % #particles
m = length(Y(1,:));

X = drawInitPart(N);

k = 10;
sigmas = linspace(1.5,3,k);
logLike = zeros(1,k); %not normalized

for i = 1:k;
    w = p(X, Y(:,1),sigmas(i));
    logLike(i) = log(mean(w));

    for n=1:m-1
        %updating
        X = updatePart(X);
        w = p(X, Y(:,n+1), sigmas(i));
        
        %resampling
        inds = randsample(N,N,true,w);
        X = X(:,inds);
        
        %estimation of log(cn)
        logLike(i) = logLike(i) + log(mean(w));    
    end
end

[~, indmax] = max(logLike);
sigmamax = sigmas(indmax)
figure
plot(sigmas,logLike./m)

