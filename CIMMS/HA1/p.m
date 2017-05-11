function [w] = p(X, y, sigma)
% in : X is an 8xN matrix where each column represents a particle,
%      y is a 8x1 vector representing an observation
%      sigma is standard deviation of the noise on the observation
% out : w is a 1xN vecor containing the likelihoods p(y|part) of each particle

load('stations')
if(nargin<3)
    sigma = 1.5;
end

v = 90;
eta = 3;
s = size(X);
N = s(2);

mu = zeros(6,N);
for l=1:6
    x = [X(1,:);X(4,:)];
    A = x-repmat(pos_vec(:,l),1,N);
    norms = sqrt(A(1,:).^2+A(2,:).^2);
    mu(l,:) = v-10*eta*log10(norms);
end

B = repmat(y,1,N)-mu;
C = zeros(1,N);
for l=1:6
    C = C + B(l,:).^2;
end
if(nargin<3)
    w = exp(-1/2*sigma^(-2)*C);%we drop the constant, only the relative weights are important
else
    w = sigma^(-6)*exp(-1/2*sigma^(-2)*C); 
end
end

