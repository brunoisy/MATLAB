load('RSSI-measurements')
load('stations')
rng(3)

N = 200; % #particles
m = 100;

delta = 0.5;
alpha = 0.6;
phi_tild = [1,delta,delta^2/2; 0,1,delta; 0,0,alpha];
psi_z_tild = [delta^2/2; delta; 0];
psi_w_tild = [delta^2/2; delta; 1];
phi = [phi_tild,zeros(3,3); zeros(3,3),phi_tild];
psi_z = [psi_z_tild,zeros(3,1); zeros(3,1),psi_z_tild];
psi_w = [psi_w_tild,zeros(3,1); zeros(3,1),psi_w_tild];

Zvalues = [0,3.5,0,0,-3.5; 0,0,3.5,-3.5,0];

sigmaX0 = diag(sqrt([500,5,5,200,5,5]));


% We draw from q
X = zeros(8,N); % Xtilde
X(1:6,:) = randn(6,N);
for i=1:6
    X(i,:)=X(i,:)*sigmaX0(i,i);
end
X(7:8,:) = datasample(Zvalues',N)'; %problem : how to update Z?

w = zeros(1,N);
for i=1:N %vectorise
    w(i) = p(Y(:,1), X(:,i));
end




% for i=1:N %vectorise
%     X(1:6,i) = mvnrnd(zeros(6,1),sigmaX0);
%     X(7:8,i) = Zvalues(:,randi(5));
% %     w(i) = p(Y(:,1), X(:,i));
% % end
% 
% for n=1:m
%     for i=1:N
%         % draw from gn(...)
%         X(1:6,i) = phi*X(1:6)'+ psi_z*X(7:8)' + psi_w*mvnrnd(zeros(2,1),sigmaW)';
%         wtemp = ones(1,5);
%         wtemp(ind) = 16;
%         ind = randsample(5, 1, true, wtemp);
%         X(7:8,i) = Zvalues(:,ind);
%         
%         % update weights
%         w(i) = p(Y(:,n), X(:,i))*w(i);
%         
%     end
%     tau(1) = sum(X(1,:).*w)/sum(w);
%     tau(2) = sum(X(4,:).*w)/sum(w);
% end






% N = 1000;
% n = 60;
% tau = zeros(1,n); % vector of estimates
% p = @(x,y) normpdf(y,x,S); % observation density, for weights
% part = R*sqrt(1/(1 - A^2))*randn(N,1); % initialization
% w = p(part,Y(1));
% tau(1) = sum(part.*w)/sum(w);
% for k = 1:n, % main loop
%     part = A*part + R*randn(N,1); % mutation
%     w = w.*p(part,Y(k + 1)); % weighting
%     tau(k + 1) = sum(part.*w)/sum(w); % estimation
% end