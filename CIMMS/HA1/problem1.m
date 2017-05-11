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
hold on
title('random trajectory for m=100')
plot(X1(1,1),X2(1,1),'*b')
plot(X1(1,end),X2(1,end),'*r')
plot(X1,X2,'k')
xlabel('$x_1$','FontSize',16,'Interpreter','latex');
ylabel('$x_2$','FontSize',16,'Interpreter','latex');
legend('Startpoint','Endpoint')