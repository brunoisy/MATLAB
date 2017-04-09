function [w] = weighPart(X, y)

s = size(X);
N = s(2);

w = zeros(1,N);

mu = zeros(6,N);
for i=1:N    
    for l=1:6
        x = [X(1,i);X(4,i)];
        mu(l,i) = v-10*eta*log10(norm(x-pos_vec(l)));
    end
    sigmaInv = eye(6)*zeta^(-1);
    w(i) = 1/(sqrt(2*pi*zeta))*e^(-1/2*(y-mu(l,i))'*sigmaInv*(y-mu(l,i)));
end


end

