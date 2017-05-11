function [ theta, lambda, t ] = post_f(tau,d,N,vartheta,rho)
% draws N samples from the posterior distribution f(theta,lambda,t|tau),
% using d-1 breakpoints

burn_in = 1000; %Burn in, ensures stationary conditions
M = N + burn_in;

theta = zeros(1,M);
lambda = zeros(d,M);
t = zeros(d+1,M); 

%draw from prior
theta(1) = gamrnd(2,vartheta);
lambda(:,1) = gamrnd(2,theta(1),1,d);
t(:,1) = linspace(1851,1963,d+1);

for k = 1:(M-1);
    %draw N thetas from posterior using Gibbs
    %pdf = @(x) 1/x^(2*d-1)*exp(-x/bigTheta-sum(lambda(:,k))/x);
    theta(k+1) = gamrnd(2*d+2,vartheta*sum(lambda(:,k))) ;
    
    %draw N lambdas from posterior using Gibbs
    for i = 1:d
        ni = sum(tau(t(i,k)<tau) < t(i+1,k));
        lambda(i,k+1)= gamrnd(ni+2, 1/(theta(k+1)+t(i+1,k)-t(i,k)));
    end
    
    %draw N ts from the posterior distribution using MH
    R = rho*(t(3:end,k)-t(1:end-2,k)); %Generating parameter for generating candidates
    cand = [t(1,k); (t(2:(end-1),k) + 2*R.*rand([1,d-1])'-R); t(end,k)]; %Candidate vector incl fixed start/endpoints
    alpha = min(post_ft(cand,lambda(:,k))./post_ft(t(:,k),lambda(:,k)),1); %Accept/reject probability
    nextT = t(:,k);
    random = rand(d-1,1);
    nextT([false; (random <= alpha); false]) = cand(random<=alpha); %Updating t-vector using accept/reject
    t(:,k + 1) = nextT;
end

theta = theta((burn_in+1):end);
lambda = lambda(:,(burn_in+1):end);
t = t(:,(burn_in+1):end);
end

