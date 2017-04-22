load('Data/RSSI-measurements')
load('Data/stations')
rng(3)

m = 500;
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


% final trajectory
X1 = X(1,:);
X2 = X(4,:);





%%%%%%%%%%%%%%%%%%%

% TESTING SIS
v = 90;
eta = 3;
zeta = 1.5;

% generating observations
Ytest = zeros(6,m);
for n=1:m
    for l=1:6
        Ytest(l,n) = v-10*eta*log10(norm([X1(n);X2(n)]-pos_vec(:,l))) + zeta*randn(1);
    end
end

% checking predictions
N = 10000; % #particles

X = drawInitPart(N);

w = p(X, Ytest(:,1));

tau1 = zeros(1,m);
tau2 = zeros(1,m);

tau1(1) = sum(X(1,:).*w)/sum(w);
tau2(1) = sum(X(4,:).*w)/sum(w);


for n=1:m-1
    %updating
    X = updatePart(X);
    w = p(X, Ytest(:,n+1));
    
    %estimation
    tau1(n+1) = sum(X(1,:).*w)/sum(w);
    tau2(n+1) = sum(X(4,:).*w)/sum(w);
    
    %resampling
    inds = randsample(N,N,true,w);
    X = X(:,inds);
end




% Plotting
% Trajectory
figure
hold on
title('estimated trajectory of the target using SISR','FontSize',14)
plot(tau1,tau2,'*') % estimated trajectory
plot(pos_vec(1,:),pos_vec(2,:), 'or','MarkerFaceColor','r') % stations
xlabel('$x_1$','FontSize',16,'Interpreter','latex');
ylabel('$x_2$','FontSize',16,'Interpreter','latex');
lgd = legend('estimated trajectory', 'stations');
lgd.FontSize = 12;

