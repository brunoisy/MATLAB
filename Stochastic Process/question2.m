% you need to create folder 'images_q2' in current directory

sigmaTheta = 0.1;
sigmaA = 0.2;

T = 0.5;
n = 200;
t = 0:T:(n-1)*T;
X0 = [1;1;1;1];
Gamma = [T*T/2,0; 0,T*T/2; T,0; 0,T];
F = [1,0,T,0; 0,1,0,T; 0,0,1,0; 0,0,0,1];

Wpd = makedist('Normal','sigma',sigmaTheta);
Vpd = makedist('Normal','sigma',sigmaA);
W = random(Wpd,1,n);
V = random(Vpd,2,n);

X = zeros(4,n+1);
Z = zeros(1,n);

X(:,1) = X0;
for k = 1:n
    Xk = X(:,k);
    H = atan2(Xk(1),Xk(2)); % true angle
    Z(k) = H + W(k); % measured angle
    Eps = Gamma*V(:,k); % noise on acceleration
    X(:,k+1)= F*Xk + Eps;
end

%%%%%%%%%%%%%%%%%

title1 = strcat('trajectory of relative positions for sigmaTheta = ', num2str(sigmaTheta),' and sigmaA = ', num2str(sigmaA));
title2 = strcat('z/pi versus time for sigmaTheta = ', num2str(sigmaTheta),' and sigmaA = ', num2str(sigmaA));

figure('Name',title1,'NumberTitle','off')
hold on
title(title1)
xlabel('X-axis')
ylabel('Y-axis')
plot(X(1,:),X(2,:));
saveas(gcf,strcat('images_q2/pos_sigThet_',num2str(100*sigmaTheta),'_sigA_',num2str(100*sigmaA),'.jpg'))

figure('Name',title2,'NumberTitle','off')
hold on
title(title2)
xlabel('time(seconds)')
ylabel('z/pi')
plot(t,Z/pi);
saveas(gcf,strcat('images_q2/z_on_pi_sigThet_',num2str(100*sigmaTheta),'_sigA_',num2str(100*sigmaA),'.jpg'))

