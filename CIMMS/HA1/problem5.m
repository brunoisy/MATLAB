load('RSSI-measurements-unknown-sigma')
load('stations')
%rng(3)

N = 20000; % #particles
m = 1;%length(Y(1,:));

X = drawInitPart(N);

k = 5;
sigmas = linspace(1,3,k);
logLike = zeros(1,length(sigmas)); %not normalized

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
logLike./m %normLogLike
sigmamax = sigmas(indmax)




