function N = buildN(Ts, Us, tau, nu)
% builds matrix N

p = length(Ts);
q = length(Us);
q1 = length(tau);
q2 = length(nu);
d = Ts(2) - Ts(1);
e = Us(2) - Us(1);

N = sparse(p*q, q1*q2);
B1 = zeros(1,4);
B2 = zeros(1,4);

for i2 = 1:q
    for i1 = 1:p
        i = i1+p*(i2-1);
        r = ceil(i1*q1/p);
        s = ceil(i2*q2/q);
        
        for j1 = r:min(r+3,q1)
            B1(j1+1-r) = B(4+r-j1, (Ts(i1)-tau(r))/d);
        end
        for j2 = s:min(s+3,q2)
            B2(j2+1-s) = B(4+s-j2, (Us(i2)-nu(s))/e);
        end
        for j2 = s:min(s+3,q2)
            for j1 = r:min(r+3,q1)
                j = j2+q2*(j1-1);
                N(i,j) = B1(j1+1-r)*B2(j2+1-s);
            end
        end      
    end
end

end