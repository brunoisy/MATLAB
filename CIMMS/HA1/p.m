function out = p(y, x)
load('stations')
v = 90;
eta = 3;
zeta = 1.5;
mu = zeros(6,1);
for l=1:6
    mu(l) = v-10*eta*log10(norm([x(1);x(4)]-pos_vec(:,l)));
end
out = mvnpdf(y, mu, eye(6,6)*zeta);

end

