function [w] = p(part, y, sigma)

load('stations')
if(nargin<3)
    sigma = 1.5;
end
v = 90;
eta = 3;
s = size(part);
N = s(2);

mu = zeros(6,N);
for l=1:6
    x = [part(1,:);part(4,:)];
    A = x-repmat(pos_vec(:,l),1,N);
    norms = sqrt(A(1,:).^2+A(2,:).^2);
    mu(l,:) = v-10*eta*log10(norms);
end

B = repmat(y,1,N)-mu;
C = zeros(1,N);
for l=1:6
    C = C + B(l,:).^2;
end

w = exp(-1/2*sigma^(-2)*C); %we drop the constant, only the relative weights are important
end

