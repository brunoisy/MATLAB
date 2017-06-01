%PROBLEM 2
load('atlantic')
%a) F^-1(u;mu,beta)=mu-beta(ln(-ln(u)))

inverse_gumbel = @(u,mu,beta) mu-beta*(log(-log(u))); 

%b) Initial estimate of parameters

[beta, mu] = est_gumbel(atlantic);
A = [mu,beta];

%Bootstrap
B=500;
n=length(atlantic);
for b=1:B
    
    for i=1:n
        U = rand; 
    boot_data(i) = inverse_gumbel(U,mu,beta);
    end
    [beta_est, mu_est]=est_gumbel(boot_data);
    
   boot(b,:)=[mu_est beta_est];
   
end


delta = sort(boot-repmat(A,B,1));
delta_mu = delta(:,1);
delta_beta = delta(:,2);

alpha= 0.05;

L_mu = mu-delta_mu(ceil((1-alpha/2)*B));
U_mu = mu-delta_mu(ceil((alpha/2)*B));

CI_mu = [L_mu, U_mu]

L_beta = beta-delta_beta(ceil((1-alpha/2)*B));
U_beta = beta-delta_beta(ceil((alpha/2)*B));

CI_beta = [L_beta, U_beta]


%c)

T= 3*14*100; %T

hundred_est = inverse_gumbel((1-1/T),mu,beta);

%Bootstrap return values

for b=1:B
   hundred_boot(b) = inverse_gumbel(1-1/T, boot(b,1),boot(b,2));
end


delta = sort(hundred_boot-hundred_est);

Onesided_CI = [0,hundred_est - delta(ceil(alpha*B))]




    