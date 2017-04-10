function [w] = p(part, y)

s = size(part);
N = s(2);

load('stations')
v = 90;
eta = 3;
zeta = 1.5;

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
w = 1/sqrt(2*pi*zeta)*exp(-1/2*zeta^(-1)*C);

end

