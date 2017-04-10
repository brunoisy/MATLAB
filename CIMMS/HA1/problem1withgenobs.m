clc, clear all, close all
load('RSSI-measurements')
load('stations')
rng(3)

m = 100;
delta = 0.5;
alpha = 0.6;
phi_tild = [1,delta,delta^2/2; 0,1,delta; 0,0,alpha];
psi_z_tild = [delta^2/2; delta; 0];
psi_w_tild = [delta^2/2; delta; 1];
phi = [phi_tild,zeros(3,3); zeros(3,3),phi_tild];
psi_z = [psi_z_tild,zeros(3,1); zeros(3,1),psi_z_tild];
psi_w = [psi_w_tild,zeros(3,1); zeros(3,1),psi_w_tild];


% generating driving commands
Zvalues = [0,3.5,0,0,-3.5; 0,0,3.5,-3.5,0]; % each column is one possible command
Z = zeros(2,m);
Z(:,1) = Zvalues(:,randi(5));
for n=1:m-1
    ind = randi(20);
    if(ind<6)
        Z(:,n+1) = Zvalues(:,ind);
    end
end

% generating random accelerations
sigmaW = 0.5;
W = randn(2,m+1)*sigmaW; %W(:,0) is useless

% generating initial state
sigmaX0 = diag(sqrt([500,5,5,200,5,5]));
X = zeros(6,m+1);
X(:,1) = randn(1,6)*sigmaX0;


% generating successive states according to model dynamics
for n=1:m
    X(:,n+1) = phi*X(:,n) + psi_z*Z(:,n) + psi_w*W(:,n+1);
end


% plot
X1 = X(1,:);
X2 = X(4,:);

figure
plot(X1,X2)
xlabel('x1');
ylabel('x2');



%%%%%%%%%%%%%%%%%%%


v = 90;
eta = 3;
zeta = 1.5;

% TESTING sequential monte carlo
% generating observations
Ytest = zeros(6,m);
for n=1:m
    for l=1:6
        Ytest(l,n) = v-10*eta*log10(norm([X1(n);X2(n)]-pos_vec(:,l))) + zeta*randn(1);
    end
end

% checking predictions
N = 1000; % #particles

X = drawInitPart(N);
w = p(X, Ytest(:,1));

tau1 = zeros(1,m);
tau2 = zeros(1,m);


for n=2:m
    X = updatePart(X);
    w = w.*p(X, Ytest(:,n));
    
    tau1(n) = sum(X(1,:).*w)/sum(w); %n=1?
    tau2(n) = sum(X(4,:).*w)/sum(w);
end
hold on
plot(tau1,tau2,'g*')
%plot(OneTrajx,OneTrajy,'g*')